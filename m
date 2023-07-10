Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD8074D19E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInHW-0002km-ID; Mon, 10 Jul 2023 05:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qInHT-0002ec-2R
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qInHO-0007TB-0a
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688981641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cx46aOGAMa8xflP9tsScr4+be4m9qjTPL9HA6OYcFME=;
 b=Hk3lxEWMASNYGusEyaKxiJqbERKcQIE6fc+eR2ZCUVkdk1LTtoYEeZy3Rh03yOpovfIxtY
 z0ZQ0UUh4g/IXbTN5tnP6jgq21xn73VMtI0n55lAcS/I1oq2NVs2E1b2as4WlzGY8wop6M
 x0jrXkj/kFKV0tLU4u4kmRhd2BtDRRg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-U8YWu3YOPA-CHUDDjiHI3g-1; Mon, 10 Jul 2023 05:33:58 -0400
X-MC-Unique: U8YWu3YOPA-CHUDDjiHI3g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635a4267cf5so39175026d6.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688981638; x=1691573638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cx46aOGAMa8xflP9tsScr4+be4m9qjTPL9HA6OYcFME=;
 b=H9aNyLNaJNRIZIkelLJJ+6f0RdpVkkDPW39BKdvXE5Neo8UxfQjjVkDunkudQlnM37
 QdE1w+AwPrCjOkW5GlbIV3OiujIko0DpYNvguEfPGfD1rG1WRYRZW/fIm3D6YbqO0iGq
 MazEjRFEF4ebLmRbCmp8q9X6XHPm8BwaDhg5Mgv9hJ+cKEdn0OVaJj4LSMFytBzdsxoT
 0k1BxBpevyZYlCE+f4j/1Bdvxr0b8wCYlZqSudE3JgXqlNqAZlJLZ4kn9oATQMEgKWb3
 46yeZayY73jjMqS2fbVi5bhswMTiQ82W9bsNzI8easVQSvVCTiWJPF+PF9xFqogFOGDx
 w5nA==
X-Gm-Message-State: ABy/qLYjEhOH4RQl91OWznPB9QcdsKfJy1IXquu/nZtGwj+BTUMWcYdY
 ek49xGMV4HXofJ0oLBalCeB1BW5NMxppfiQoMDdaM+zKISKZk9r/TAqZ2o4PGW7Q9/HlUx/nBQq
 j3c70n5O93aygoNs=
X-Received: by 2002:a0c:db02:0:b0:637:3ca5:cc55 with SMTP id
 d2-20020a0cdb02000000b006373ca5cc55mr10314660qvk.41.1688981638388; 
 Mon, 10 Jul 2023 02:33:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUB+VIOerxBAKY6oTTE8ihcxRRslwl7/Qm+0QvUtiy/kgLQjPZrDjT0Ynzby4dobu22oynMw==
X-Received: by 2002:a0c:db02:0:b0:637:3ca5:cc55 with SMTP id
 d2-20020a0cdb02000000b006373ca5cc55mr10314650qvk.41.1688981638125; 
 Mon, 10 Jul 2023 02:33:58 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 i16-20020a0cf390000000b0063640486254sm5364316qvk.116.2023.07.10.02.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 02:33:57 -0700 (PDT)
Message-ID: <d124fc1f-569c-f2ec-f515-7e4ad921884f@redhat.com>
Date: Mon, 10 Jul 2023 11:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230710091439.1010553-1-kkostiuk@redhat.com>
 <20230710091439.1010553-2-kkostiuk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230710091439.1010553-2-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/07/2023 11.14, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/meson.build   |  2 +-
>   qga/vss-win32/vss-debug.cpp | 39 +++++++++++++++++++++++++++++++++++++
>   qga/vss-win32/vss-debug.h   | 25 ++++++++++++++++++++++++
>   3 files changed, 65 insertions(+), 1 deletion(-)
>   create mode 100644 qga/vss-win32/vss-debug.cpp
>   create mode 100644 qga/vss-win32/vss-debug.h


Reviewed-by: Thomas Huth <thuth@redhat.com>


