Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25FB71484B
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3agR-0001Os-8r; Mon, 29 May 2023 07:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3agO-0001Od-Kj
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3agM-0000lS-Dg
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685358296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSJQkwAriwY1hRd+d7soJoDDQFce0F53jV05KLmgVCo=;
 b=SlcSDhmHC2f/wpfyZSaJCnCHH9JW9I92aH4nml2TzxkHlhaMGzGImSOErqvhEJLKb5QKGn
 zXRp4/CyUWCo8/X91i/e6jHb0O65/3O9Gp7aO7T/TYMJmbO76/UHW6azEepdU9jg6I2U65
 eXgxwY2wxc+OQpL89kPGZM+ndB+VbjQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Gfl0n8mfMCOJxE7VKOx8_g-1; Mon, 29 May 2023 07:04:54 -0400
X-MC-Unique: Gfl0n8mfMCOJxE7VKOx8_g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96fd3757bd1so370068166b.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 04:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685358294; x=1687950294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSJQkwAriwY1hRd+d7soJoDDQFce0F53jV05KLmgVCo=;
 b=D45aYcY/9JV2dOaih+kysZZqHLasOJAJLdRrJzCOLWn3D+1O2fwvYcHihqjAAGgWeQ
 uhJhoMKuUQ6svDGRHEoJQlqO/tORpIZmw8q+nHOLGg6wLZvJFveE66HzYc+sSYFfHmE0
 N4fjHsu5k+VVEhodimPevxiNQaCsuAf3XVwaUCnaGA+/9N0SOTiaciQ8ny6UpImCpf4u
 mdKmSaMlOR70AC6f1hoD8ByGIyJUgDoEDnzmAprdI01A+OCC3TH56cFfgn2ssjRnERqk
 1Yq/1xwQJpfwiUTh56gTWWYD9wPSEPRfPfL5BQTnCIyX7Af4jtYXOxLaKTZzYaCCJjC4
 vPOw==
X-Gm-Message-State: AC+VfDyqoA6QzKV5UE+V6dfDd3Dwa2qgfB+RU6p57acnFK7TJmMZZWXN
 wZc/WdbuHVV31Q2peL2L/mfvXhTIYvHkB+LhuTR3vLfLMzQ4wW/gNqs0HlOc3+gWVyaYPgNMjRD
 7koVlgifmJ42sMnQ=
X-Received: by 2002:a17:907:3f8f:b0:973:9c54:572c with SMTP id
 hr15-20020a1709073f8f00b009739c54572cmr12029109ejc.14.1685358293806; 
 Mon, 29 May 2023 04:04:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eaj6TfksyJghgF1/RtjgP0WPuGN50Q46lZlEcFClAtOVurje1aiuV582tyaX1dlYzZ+cL7A==
X-Received: by 2002:a17:907:3f8f:b0:973:9c54:572c with SMTP id
 hr15-20020a1709073f8f00b009739c54572cmr12029091ejc.14.1685358293418; 
 Mon, 29 May 2023 04:04:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 v19-20020a1709060b5300b0096621340285sm5792026ejg.198.2023.05.29.04.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 04:04:52 -0700 (PDT)
Message-ID: <ca82a193-1be7-9b81-8e65-1de65efb842f@redhat.com>
Date: Mon, 29 May 2023 13:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] meson: Avoid implicit declaration of functions
To: Peter Maydell <peter.maydell@linaro.org>,
 Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org
References: <068f343a62de3dbc3764d0ad98111881b04a60d2.1685346951.git.mprivozn@redhat.com>
 <CAFEAcA_e9JmNacpFyG+SZareve2HJx+dFQwLbjyhmr6brm=9QQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA_e9JmNacpFyG+SZareve2HJx+dFQwLbjyhmr6brm=9QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/23 12:24, Peter Maydell wrote:
> On Mon, 29 May 2023 at 08:58, Michal Privoznik <mprivozn@redhat.com> wrote:
>>
>> While detecting a presence of a function via 'cc.links()'
>> gives desired result (i.e. detects whether function is present),
>> it also produces a warning on systems where the function is not
>> present, e.g.:
>>
>>    qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
>>    warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]
> 
> Produces a warning where ? On stdout/stderr ?
> 
> The linked bug report says "in the configure logs"
> which is kinda vague. Warnings in the logfiles are
> not a problem; warnings in the terminal output are...

It seems to be a lint:

  * QA Notice: Found the following implicit function declarations in configure logs:
  *   /var/tmp/portage/app-emulation/qemu-7.2.0-r3/work/qemu-7.2.0/tools-build/meson-logs/meson-log.txt:562 - malloc_trim
  *   /var/tmp/portage/app-emulation/qemu-7.2.0-r3/work/qemu-7.2.0/tools-build/meson-logs/meson-log.txt:591 - statx
  *   /var/tmp/portage/app-emulation/qemu-7.2.0-r3/work/qemu-7.2.0/tools-build/meson-logs/meson-log.txt:627 - statx
  *   /var/tmp/portage/app-emulation/qemu-7.2.0-r3/work/qemu-7.2.0/softmmu-build/meson-logs/meson-log.txt:718 - malloc_trim
  *   /var/tmp/portage/app-emulation/qemu-7.2.0-r3/work/qemu-7.2.0/softmmu-build/meson-logs/meson-log.txt:747 - statx
  *   /var/tmp/portage/app-emulation/qemu-7.2.0-r3/work/qemu-7.2.0/softmmu-build/meson-logs/meson-log.txt:783 - statx
  * Check that no features were accidentally disabled.
  * See https://wiki.gentoo.org/wiki/Modern_C_porting.

So, not an actual bug but more of a favor that we can do to the distros.

>> +    cc.has_function('malloc_trim', prefix: '#include <malloc.h>') and \
>>       cc.links('''#include <malloc.h>
>>                   int main(void) { malloc_trim(0); return 0; }''')
> 
> This seems super clunky -- surely this isn't the way Meson
> intends people to write tests ?

For this one can remove the cc.links test altogether, so this part of the
patch is okay.

The statx is less clear.

> 
> +statx_test = statx_prefix + '''
>    int main(void) {
>      struct statx statxbuf;
>      statx(0, "", 0, STATX_BASIC_STATS, &statxbuf);
>      return 0;
>    }'''
>  
> -has_statx = cc.links(statx_test)
> +has_statx = cc.has_function('statx', prefix: statx_prefix) and \
> +    cc.links(statx_test) 

Here we could replace cc.links with a cc.has_header_symbol('sys/stat.h',
'STATX_BASIC_STATS'), and likewise for has_statx_mnt_id below.

If it was just has_statx I would rather leave things as is.  However,
given that there is has_statx_mnt_id too, I'd apply a v2 that removes
usage of cc.links for these three tests.

Paolo


