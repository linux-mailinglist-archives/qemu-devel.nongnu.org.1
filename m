Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CA830500
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:12:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ4l6-0000tD-7X; Wed, 17 Jan 2024 07:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQ4kr-0000su-6k
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQ4kp-0004DB-2C
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705493444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rU6NL4lKtLs/qGoeKoe+LSXfrlJAqes9hxrsh54s4aE=;
 b=TOiRsPBP36La5PHhTIX9zv6rUetWv+Qx5wiRsmjRoxdV4y1Dar4zWoPV+iWnWodBy6z7Qz
 nxp9GXFsMN9d+sZklLvCki3KmqedfBzwh3OnwbJc/Yc0qrocOBssY6ju9cmcLy2sjv8AZT
 p5UWWOMBq5XfSLxDk9I26uPKCkh/mxI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-kkYicJl7N0qh5MigyGCt1A-1; Wed, 17 Jan 2024 07:10:42 -0500
X-MC-Unique: kkYicJl7N0qh5MigyGCt1A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7816bea8d28so1966544085a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705493442; x=1706098242;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rU6NL4lKtLs/qGoeKoe+LSXfrlJAqes9hxrsh54s4aE=;
 b=D0BNZB6gWU1Kq06iZ1iGneVSNM565JRr5r6vl5EG2VGgU1ZtuusszoD5Y3BIrdajj+
 eWEdamkHT1xalKY7/Z6DdKCPSnwdpZkPoFaqaSPRx+ioSH7/nhLPUP+0tfeIbnGQ0666
 EZQSfIyCrsaS7Su0qGR8jzmz2eh8DICJEE7eZ7be3qTTMUCDikhFagvyUHcLZ/Ky1KTs
 a850jlBwAR6GMVWV2jFfqIonqGlZkE027S5I0Er1BOFceGl82ivksuCgS0Ly9mnHEzqQ
 kSuL5sUvYqCqgnYY1X04teCBN6MCTfuzrL623IANiELLOM0xhHjfA/IbqS/2rb/U8w2D
 ArTQ==
X-Gm-Message-State: AOJu0YwAeK04KmuSXQAjTAWzDih9jpJsZX9j108YAOwpGsSjJpD7CV4/
 NsEAYSyWv378pb1ycSZzcelBYtwT3qYuBLdwv7L86uCYVdlX5Wq8jq0Rs+ZOo1IeVxtQ8QF25XY
 3t8jpbvUMYgjR7XHDfQLnvCjF1Lr7ewsfqa/rahYBMhpCtfZMUcM0
X-Received: by 2002:ae9:ee05:0:b0:781:13cb:5888 with SMTP id
 i5-20020ae9ee05000000b0078113cb5888mr778468qkg.56.1705493442514; 
 Wed, 17 Jan 2024 04:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgOp/TE3cvbL75zC7uGbSuKdkHmzROd2Uq2DWe16qlCugnLES5VqTu3DcW/2vUKyNNB7g1pg==
X-Received: by 2002:ae9:ee05:0:b0:781:13cb:5888 with SMTP id
 i5-20020ae9ee05000000b0078113cb5888mr778457qkg.56.1705493442162; 
 Wed, 17 Jan 2024 04:10:42 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 t5-20020ac865c5000000b00427fabefe3bsm5740064qto.52.2024.01.17.04.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 04:10:41 -0800 (PST)
Message-ID: <5ae6d41e-e291-4fa1-94a1-6ec22cd809be@redhat.com>
Date: Wed, 17 Jan 2024 13:10:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/vm/netbsd: Remove missing py311-expat package
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240117112407.22462-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240117112407.22462-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 17/01/2024 12.24, Philippe Mathieu-Daudé wrote:
> Per commits a9dbde71da ("mkvenv: add better error message for
> broken or missing ensurepip") and 1dee66c693 ("tests/vm: add
> py310-expat to NetBSD"), we need py-expat to use ensurepip.
> 
> However the py311-expat package isn't available anymore:
> 
>    ### Installing packages ...
>    processing remote summary (http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All)...
>    database for http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All is up-to-date
>    py311-expat is not available in the repository
>    ...
>    calculating dependencies.../py311-expat is not available in the repository
>    pkg_install error log can be found in /var/db/pkgin/pkg_install-err.log
> 
> Dropping it from the default packages list allows creating the
> NetBSD VM and build / test QEMU, without error from ensurepip.
> 
> This reverts commit 1dee66c693 ("tests/vm: add py310-expat to NetBSD").
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2109
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC because ensurepip seems important due to cited commits
>      but I'm not sure where it is used, and this fixes my CI build.

Thanks for tackling it, I also ran into this problem already and just did 
not have enough spare time yet to investigate.

I searched a little bit, and found this text here:
https://mail-index.netbsd.org/netbsd-announce/2024/01/01/msg000360.html

"
- Several packages have been folded into base packages.  While the
    result is simpler, those updating may need to force-remove the
    secondary packages, depending on the update method.  When doing
    make replace, one has to pkg_delete -f the secondary packages.
    pkgin handles at least the python packages correctly, removing the
    split package when updating python.  Specific packages and the
    former packages now included:

      * cairo: cairo-gobject
      * python: py-cElementTree py-curses py-cursespanel py-expat
        py-readline py-sqlite3
"

So it seems like the py-expat package has simply been merged into a base 
package now. Thus I think your patch is fine. It also fixes the problem for 
me, so:

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>


