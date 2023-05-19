Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBEF709B02
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01p2-0000Bt-AV; Fri, 19 May 2023 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01p0-00007y-B1
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01oy-00044R-O4
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ibx0s4BuzeEZLgxNwhc0EU/PYP1e7Z2TbZnB9+LksSU=;
 b=bUjoppaO2asex6JaWnt/nDoDk1dL6HD3FZCgQQfPdMYYz6E4RZ231D8pzgjj2fL/z1Brci
 TbruPKFDtISSG9HbtnKlGORpLWRYrPNley0ISbpfUOBsPNpY9K7gJQ7UE3Rx8H/KdKxX3Y
 sROGe49zhbIos548Ji7bh7LoCl3C994=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-9oNf9cZHNAGpvN62U93cHA-1; Fri, 19 May 2023 11:15:05 -0400
X-MC-Unique: 9oNf9cZHNAGpvN62U93cHA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-965b73d8b7eso369109466b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684509304; x=1687101304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ibx0s4BuzeEZLgxNwhc0EU/PYP1e7Z2TbZnB9+LksSU=;
 b=icexalGNDJ737FZOwNlT7IwkzBuYjvHCvxtDUN+rJOL0F1KdLCYKQPDQP9jbbruO52
 N7i6+Qv8WOSTd24AJgdYn1OGrBh7LDSYzPiKx+kHdRevIcT10fPD98cHz2SwKWb3GvMV
 lKx9xjIWhRJW11F6ruZfHA5q2lXIvSZXIN8fI/F92id6yBSRGpKVhdJd0hgiVaUtGEf/
 EACL2DVSbbq6MI14QBdHGWQ5dYEsGrauPeNurvJMKy8EJTMFcqCcn3XO3/zqn58/Ubzt
 wJfXidtzZ7pLjJEpGBViKuCvm8FVa06VnaqczWKjAUXPmAVJIk8Vdkw0lFSrv++tTSsG
 NREg==
X-Gm-Message-State: AC+VfDzZeiUr03HwrJrTueqC5oD2EX+nARVhfFJm+IaREjS08vxgvYQZ
 6+jZqivRzsUoFy+uQrYVbglA8VjfI9sdl88FKPaNiAN0NRX0TuLZLOAhj01It7R1jTLZcJMI8dY
 EgtCXTBGLsxY0/zo=
X-Received: by 2002:a17:907:6e03:b0:94f:322d:909d with SMTP id
 sd3-20020a1709076e0300b0094f322d909dmr2387918ejc.63.1684509304191; 
 Fri, 19 May 2023 08:15:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66S/tEGcZZRj1zBf9VNboqfCnl5wTcoMJHfcY+Or//rk0eTFuYuMLnRqtksKi5XHUt0+HFzg==
X-Received: by 2002:a17:907:6e03:b0:94f:322d:909d with SMTP id
 sd3-20020a1709076e0300b0094f322d909dmr2387898ejc.63.1684509303929; 
 Fri, 19 May 2023 08:15:03 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 gv16-20020a170906f11000b0094ef923a6ccsm2383128ejb.219.2023.05.19.08.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:15:03 -0700 (PDT)
Message-ID: <13316404-8ab5-ea99-679c-7f1854e222d7@redhat.com>
Date: Fri, 19 May 2023 17:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 12/19] cutils: Allow NULL str in qemu_strtosz
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-13-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-13-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12.05.23 04:10, Eric Blake wrote:
> All the other qemu_strto* and parse_uint allow a NULL str.  Having
> qemu_strtosz crash on qemu_strtosz(NULL, NULL, &value) is an easy fix
> that adds some consistency between our string parsers.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/unit/test-cutils.c | 3 +++
>   util/cutils.c            | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


