Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4226753C2E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 15:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKJCz-0001bg-BS; Fri, 14 Jul 2023 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qKJCx-0001bH-JE
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 09:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qKJCv-0002mx-RX
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 09:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689342700;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbK7C1cY4inqI6DCLA63VTZ1MQc13E9PBJM6GxlAsMY=;
 b=EQ1GZ4qrPvTrmRSgZfvt10GOA1CAgbUYk0nBJmGla8FMb2weUMESVw88PeBUdyVTt/KK+o
 jtZQSf0jDJ98Uf4k6kDBBU74FmBeaYHhiWia384TBBsNdrCxppHBwhHmhlzcN+XEWVIqsr
 oucfzSbjGFy7NKqRzdX79Cnqd3RoL/c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-rojNlXxiPpanTlTR74Ebkw-1; Fri, 14 Jul 2023 09:51:39 -0400
X-MC-Unique: rojNlXxiPpanTlTR74Ebkw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-403ae7d56baso21689411cf.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 06:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689342698; x=1689947498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbK7C1cY4inqI6DCLA63VTZ1MQc13E9PBJM6GxlAsMY=;
 b=VtjrnGaV8e7eqj6GGhvh87QmKoGVsXwuyEOVEEMSYH+jupkFs6s6NoTZLSkGmU4piz
 npiOsD9fjOff0bRJAvjogSkuhUJ29UaPjPhPJJPrk8exVxO0Qxlp+N2OfrF0bYpCl3ow
 fAzF71N8ye51mJ3QgmtlgJYRG1RfLOxMIiRUlHIPsgbbjSLMviCaj5IYz2yVKVAV5tgB
 4sJYPmYVX1RfMnS7SjR0RBI/JdQudSCyU5VjNvaY8mOfXhnDaxTTRy5cI4jCYgRZ/J41
 YqhXowtq4flIm73IljkxsBskEVHMZEDW8vSqJX9FvIK6Bzeh1r/P+Uk4+NqzrBLjPUY4
 0iHg==
X-Gm-Message-State: ABy/qLa1V90u50Ru26Skk+GqU9Sfhj0pj60No81dLypmRVO7l6WCSMrT
 Fh+W+2BS1fm3PSIwBliteSrXmcGrHKFMdyvxkPIPWcHtbtD5M4J9F8pH1Ft/CYqA3XyMKKfcsNB
 nHvFFaz8WmRZsjDU=
X-Received: by 2002:a05:622a:1441:b0:3ff:2179:c48d with SMTP id
 v1-20020a05622a144100b003ff2179c48dmr5706753qtx.28.1689342698754; 
 Fri, 14 Jul 2023 06:51:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCyaM2EbexCizDt4ec8aSqjQjt4vYc2JYAgPASm+izn2UbmQC87EXVWYF/H8Z+cMiEyxXBEw==
X-Received: by 2002:a05:622a:1441:b0:3ff:2179:c48d with SMTP id
 v1-20020a05622a144100b003ff2179c48dmr5706736qtx.28.1689342698505; 
 Fri, 14 Jul 2023 06:51:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ac842c6000000b004009f034a6csm3966687qtm.91.2023.07.14.06.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 06:51:37 -0700 (PDT)
Message-ID: <d1a121d2-b0ec-7928-ff21-ce5389cf7749@redhat.com>
Date: Fri, 14 Jul 2023 15:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] hw/tpm: TIS on sysbus: Remove unsupport ppi command line
 option
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 ard.biesheuvel@linaro.org
References: <20230713171955.149236-1-stefanb@linux.ibm.com>
 <CA+E+eSA1O=39JRjWni1YnVg3uwWATpe2zw8EWgDEBbv+EPgU7w@mail.gmail.com>
 <56a562bf-5b3d-0914-f530-dd965587a3db@linux.ibm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <56a562bf-5b3d-0914-f530-dd965587a3db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Stefan,
On 7/14/23 13:51, Stefan Berger wrote:
>
>
> On 7/14/23 02:07, Joelle van Dyne wrote:
>> On Thu, Jul 13, 2023 at 10:20 AM Stefan Berger
>> <stefanb@linux.ibm.com> wrote:
>>>
>>> The ppi command line option for the TIS device on sysbus never worked
>>> and caused an immediate segfault. Remove support for it since it also
>>> needs support in the firmware and needs testing inside the VM.
>>>
>>> Reproducer with the ppi=on option passed:
>>>
>>> qemu-system-aarch64 \
>>>     -machine virt,gic-version=3 \
>>>     -m 4G  \
>>>     -nographic -no-acpi \
>>>     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>>>     -tpmdev emulator,id=tpm0,chardev=chrtpm \
>>>     -device tpm-tis-device,tpmdev=tpm0,ppi=on
>>> [...]
>>> Segmentation fault (core dumped)
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Do you need to add a VMSTATE_UNUSED_TEST in case a future QEMU version
>> introduces a new field in the same position which will cause an issue
>> when restoring from an older version?
>
> Hm, you got a point there. We will have to error-out in case someone
> sets ppi=on instead since the expectation that PPI would work is
> simply not there. v2 coming soon.
as Joelle pointed it out ppi_enabled is not part of
vmstate_tpm_tis_sysbus fields. And since it has never worked I suspect
we cannot have any existing VM enabling it. So I don't get the issue
with this 1st version?

Thanks

Eric
>
>     Stefan
>


