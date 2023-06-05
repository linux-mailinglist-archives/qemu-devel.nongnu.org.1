Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDE721DDD
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 08:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q63O0-0005MV-Me; Mon, 05 Jun 2023 02:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q63Nw-0005MA-Mu
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 02:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q63Nu-0006z8-Tl
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 02:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685945286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiSpvJwFG87wAdz2y11ghwnC81Na8+4kSF9GDGQmoc8=;
 b=S7rPMhUU6/Ntdph8EWagMhtYdpHo6XQd0zsgzdCgSduwe+e2ioLaODGuFC+ghUZS0D6h5E
 m2Gq5Lzh/ut/46ozVSOIcQxWVWCiUSxEq17qjXviNylC6+axhhgBnMwvSR5GsOfrp7MqiO
 vsDkvbaRjIjYN/rubx+n59Xrk8Xxthw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-uinY5auSPkq-XbF3WqoVhA-1; Mon, 05 Jun 2023 02:08:04 -0400
X-MC-Unique: uinY5auSPkq-XbF3WqoVhA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f725f64b46so56089565e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 23:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685945283; x=1688537283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xiSpvJwFG87wAdz2y11ghwnC81Na8+4kSF9GDGQmoc8=;
 b=HIvgtx2nurj8jCeg6DpKWHwWl7KubUd3pfhgerKf87SauPqweYR1N8QSVK1YgMJOWP
 S65jvo7HVZhVu1wkoWk/Xfjt1QXbcBd2TxyMpybrY5SwhR+QM0LnhsPtiCQsCKnnaI6V
 HgfLsNqvOs7imgcLSGsZvNwlBkh2zvQ4JHDrRmZBEHDoseFCV8JrHhqjNgONDX7YOde0
 MBog4g6Vqt/ZVSoFp2nG7d6F9iMqLBJ0TQ1yrVENKB9fH/aGSj8hpH3L+dP5b+lner8/
 phMS1L18On+Tz21piwb5p73EGhcjl7cug64XsH0qxqN1qZz6KCbNqn11aldbzeO43lWu
 T0PA==
X-Gm-Message-State: AC+VfDxqxyKX+RxkW8fLXPRmx4ALjrBRqddR5knEj5ShtgY8duROtulK
 Rj+5cls3CPSuNzLVzA9dUoXH29JfO5kWQs3tOo+g86Hz6iSCqJ3/0AjGhxf/a4td2jamMs1u3zv
 BZveZ9g8EWQwwLHI=
X-Received: by 2002:a05:600c:2044:b0:3f7:e4fe:1dd7 with SMTP id
 p4-20020a05600c204400b003f7e4fe1dd7mr722816wmg.13.1685945283065; 
 Sun, 04 Jun 2023 23:08:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41ByAeXCtUbk0Lq2apyD/kTRXegwqX1d7Uookd2RPkcz1UbuFf3uHBypyathfu/GOkHPk3bA==
X-Received: by 2002:a05:600c:2044:b0:3f7:e4fe:1dd7 with SMTP id
 p4-20020a05600c204400b003f7e4fe1dd7mr722799wmg.13.1685945282768; 
 Sun, 04 Jun 2023 23:08:02 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c221600b003f7a562ff31sm2249061wml.6.2023.06.04.23.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 23:08:02 -0700 (PDT)
Message-ID: <d091861d-59a9-b33f-5601-5b0dcbf1e1b5@redhat.com>
Date: Mon, 5 Jun 2023 08:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] meson.build: Group the network backend entries in a
 separate summary section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20230602171832.533739-1-thuth@redhat.com>
 <20230602171832.533739-3-thuth@redhat.com>
 <d92bc6de-17db-96a9-096d-68b396e11128@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <d92bc6de-17db-96a9-096d-68b396e11128@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 02/06/2023 22.03, Philippe Mathieu-Daudé wrote:
> On 2/6/23 19:18, Thomas Huth wrote:
>> Let's make it easier for the users to spot network-related entries
>> in the summary of the meson output.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   meson.build | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 4a20a2e712..c64ad3c365 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4267,13 +4267,19 @@ summary_info += {'curses support':    curses}
>>   summary_info += {'brlapi support':    brlapi}
>>   summary(summary_info, bool_yn: true, section: 'User interface')
>> -# Libraries
>> +# Network backends
>>   summary_info = {}
>>   if targetos == 'darwin'
>>     summary_info += {'vmnet.framework support': vmnet}
>>   endif
>> -summary_info = {}
> 
> Ah, this should be squashed in the previous patch.

Drat, thanks for catching it!

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

  Thomas

>>   summary_info += {'slirp support':     slirp}
>> +summary_info += {'vde support':       vde}
>> +summary_info += {'netmap support':    have_netmap}
>> +summary_info += {'l2tpv3 support':    have_l2tpv3}
>> +summary(summary_info, bool_yn: true, section: 'Network backends')
>> +
>> +# Libraries
>> +summary_info = {}
>>   summary_info += {'libtasn1':          tasn1}
>>   summary_info += {'PAM':               pam}
>>   summary_info += {'iconv support':     iconv}
>> @@ -4295,9 +4301,6 @@ if targetos == 'linux'
>>   endif
>>   summary_info += {'Pipewire support':   pipewire}
>>   summary_info += {'JACK support':      jack}
>> -summary_info += {'vde support':       vde}
>> -summary_info += {'netmap support':    have_netmap}
>> -summary_info += {'l2tpv3 support':    have_l2tpv3}
>>   summary_info += {'Linux AIO support': libaio}
>>   summary_info += {'Linux io_uring support': linux_io_uring}
>>   summary_info += {'ATTR/XATTR support': libattr}
> 


