Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00376CEDF
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRC0Y-0006ne-4e; Wed, 02 Aug 2023 09:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRC0U-0006nA-QH
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRC0T-00023Z-5u
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690983316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyTmqo22j7nsn3+iNT4PUGw/AD9nrAyjz6mkz0fWlkA=;
 b=MtuypVg80M1S2bxN9Vmno5wOydahb4xRFmMZPCAG+QnbVr8iFAcPI7Aq03d6Ls3VlbJXTb
 CsHjxRbRWLa8LmfbRlzWP4RQ/qwe01MT6GiWI6zrheVRslZOeFq34ZFDioUoepA8+6MyUt
 SrGWxdF5X2sQwVTPzSjaS6wz8T9YJXk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-V6FXC37JPEG5P7DULej9CQ-1; Wed, 02 Aug 2023 09:35:14 -0400
X-MC-Unique: V6FXC37JPEG5P7DULej9CQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-403b134421cso7687881cf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 06:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690983314; x=1691588114;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyTmqo22j7nsn3+iNT4PUGw/AD9nrAyjz6mkz0fWlkA=;
 b=ZIYWYivxAbNPP7JRwQBOLzuSCrgu+Xk/8yejY7x2Zfrmj0llq6rGT20pvh3m6PjwGU
 uchOxl4EREi64TBE4mHyZ0oneYmTr3f1obUKkOy7unWeKoy2H/g36IEUKOEtE23qWxwN
 AzWhNtENpnMF9AGkRPj7ZwfN25piie1E/0LA72rDOALyx7hypck9oVfSrKdUvoQiB4rd
 UNDzxoEYuVBybTn5In2CEJvkZEnnHEjAQ0Y3iMCufiiRpa2nI/ZPOroy72Svapuy7NTS
 afmPOF03vVE6u5b10F0vfotNvAlOw8+Qy3mgnBTv5EUbReg407+Q9Ed5tTfZ2V4r79Hp
 B/tg==
X-Gm-Message-State: ABy/qLb0sr5ZWoaOC2sTMZBy3iek7KUzbPE/HBOb33o8lo3pTeZISWHZ
 kAxhJlsH9v0E1HqbTDXzbkE6+TWgnFbTQ5TW4r3dNyCU2mLz+PEJ6n0ZZSKFoaTiqUBrjZRfHiv
 oa0TAkXlBWBvdwp4=
X-Received: by 2002:a05:622a:120e:b0:403:9fd0:d43e with SMTP id
 y14-20020a05622a120e00b004039fd0d43emr20884923qtx.21.1690983314315; 
 Wed, 02 Aug 2023 06:35:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGnJbO4PlQvZPB7ulCXXPDz5PhSu4n5QgRF0EtGhr96hOhH2xqbDMC+hySRkpKpGQKjxp289A==
X-Received: by 2002:a05:622a:120e:b0:403:9fd0:d43e with SMTP id
 y14-20020a05622a120e00b004039fd0d43emr20884900qtx.21.1690983314065; 
 Wed, 02 Aug 2023 06:35:14 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-230.web.vodafone.de.
 [109.43.178.230]) by smtp.gmail.com with ESMTPSA id
 q11-20020ac8450b000000b00403af2cf825sm5332573qtn.34.2023.08.02.06.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 06:35:13 -0700 (PDT)
Message-ID: <bf39003f-b7a6-582f-8c99-6395f482ea1a@redhat.com>
Date: Wed, 2 Aug 2023 15:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/i386/intel_iommu: Fix endianness problems related to
 VTD_IR_TableEntry
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230802092837.153689-1-thuth@redhat.com>
Content-Language: en-US
In-Reply-To: <20230802092837.153689-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 02/08/2023 11.28, Thomas Huth wrote:
> The code already tries to do some endianness handling here, but
> currently fails badly:
> - While it already swaps the data when logging errors / tracing, it fails
>    to byteswap the value before e.g. accessing entry->irte.present
> - entry->irte.source_id is swapped with le32_to_cpu(), though this is
>    a 16-bit value
> - The whole union is apparently supposed to be swapped via the 64-bit
>    data[2] array, but the struct is a mixture between 32 bit values
>    (the first 8 bytes) and 64 bit values (the second 8 bytes), so this
>    cannot work as expected.
> 
> Fix it by converting the struct to two proper 64-bit bitfields, and
> by swapping the values only once for everybody right after reading
> the data from memory.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: There are more endianness issues in the code, I haven't figured
>         out all of them yet, Linux fails to boot in the guest when I use
>         this device on a s390x host. But I wanted to publish this patch
>         now already since this should also fix the "issue" with the Clang
>         ms_struct packing that we recently discussed on the mailing list.

I just found the all remaining issues (I hope). I can now run a Linux guest 
with -device intel-iommu and it works without crashing now. I'll send out 
the patches shorty, after cleaning them up a little bit.

  Thomas



