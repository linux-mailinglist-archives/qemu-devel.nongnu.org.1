Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B2740B9A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:33:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQbb-00078e-JF; Wed, 28 Jun 2023 04:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEQbW-00078D-VL
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEQbV-0001b3-8s
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687941164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtoYMWBAYrsPFm1Yt9a445e/9Ijk/8k15+9rGlCeaXE=;
 b=R5hh5fpba+XMefrZR/Gv6ACDF2/tGUyPQ/cTKbmg8fwqlsVeAlkx0vsAuRZDxindFaQuek
 lGTiN704N8j5eyVjX14t0PZQW6QId5S+6CDr3pzaCIUMofNW3/hgao3dFTAgafu5Gmu69P
 puGxqFyxwUviH3lnPNoKj/TnI8IAnes=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-pEEyLnM1Owaq_kl-FfwLmA-1; Wed, 28 Jun 2023 04:32:42 -0400
X-MC-Unique: pEEyLnM1Owaq_kl-FfwLmA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-40328438392so122821cf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687941162; x=1690533162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtoYMWBAYrsPFm1Yt9a445e/9Ijk/8k15+9rGlCeaXE=;
 b=GrUxFAbrxXB/0D/ahPvTaXLepHV08q31O5eV+K+w6BaM6CDpB8HAhOTpGWC/64Kj7J
 rGJrhZSmWEQXc/c06qmpipUbYnE4TOVmJ8dkEAmyPtRNb+IFEffBKHFI1pXv65yCvHJV
 pFHUIItNs7a0TunuRQAGHMM81mKQS13ZDDm3oD9u5CoGPgWbN+r8D3+GqugyNRd/QtPa
 zyqPuiayvfIEsVcGFtiRvU45AoTx5tZ6iwzz/keN3NDicMDN9C49aMtQMc/fadWgusw6
 UqZwfDBFLt+VyZlqegWFsFsK2gegBmN8GOsMzGDoGF8STdV+CJyfwAR4Ts4gKgDaVW9V
 UVfQ==
X-Gm-Message-State: AC+VfDwOrdGGv1pgtVWHaLGj9ms3ISk82hV8G8O8P1U9nofqIPjutbVf
 E+iRSd+AYOi2ORmrxkvsXOcyQnLzm/WBB8p9y0PX2NlcRGW6iCLBrXvtP10QUxNiMVL7exMp4ZA
 CFKIEzXfF/lgotnw=
X-Received: by 2002:ac8:5f95:0:b0:402:7ff0:fab3 with SMTP id
 j21-20020ac85f95000000b004027ff0fab3mr5051923qta.54.1687941161898; 
 Wed, 28 Jun 2023 01:32:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wbu6yuwVgt3gjXJdchwr+/eYNcnUbY2cuyK9F8eOSnpK8C8UzSFrI92NrS5IT6UlWpkpxDA==
X-Received: by 2002:ac8:5f95:0:b0:402:7ff0:fab3 with SMTP id
 j21-20020ac85f95000000b004027ff0fab3mr5051905qta.54.1687941161626; 
 Wed, 28 Jun 2023 01:32:41 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-172.web.vodafone.de.
 [109.43.179.172]) by smtp.gmail.com with ESMTPSA id
 o23-20020ac85557000000b003f6bbd7863csm5594767qtr.86.2023.06.28.01.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 01:32:41 -0700 (PDT)
Message-ID: <563ee2d5-ce64-de5f-02fc-8eb08be68854@redhat.com>
Date: Wed, 28 Jun 2023 10:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pc-bios/s390-ccw: Get rid of the the __u* types
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, cohuck@redhat.com,
 Juan Quintela <quintela@redhat.com>
References: <20230627114101.122231-1-thuth@redhat.com>
 <585834bf-33a0-2a64-0bba-f1f47df41275@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <585834bf-33a0-2a64-0bba-f1f47df41275@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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

On 27/06/2023 14.19, Christian Borntraeger wrote:
> 
> 
> Am 27.06.23 um 13:41 schrieb Thomas Huth:
>> Using types starting with double underscores should be avoided since these
>> names are marked as reserved by the C standard. The corresponding Linux
> 
> In general I think this change is fine, but this is kind of interesting, as
> /usr/include/linux/types.h does have __u64 and friends. In fact there is
> __u64 but not u64 in /usr/include.
> 
> And yes a google search for double underscore  has
> 
> The use of two underscores (` __ ') in identifiers is reserved for the
> compiler's internal use according to the ANSI-C standard. Underscores
> (` _ ') are often used in names of library functions (such as " _main
> " and " _exit "). In order to avoid collisions, do not begin an
> identifier with an underscore.
> 
>> kernel header file has also been changed accordingly a long time ago:
>>
>>   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a
> 
> but IIRC from a kernel perspective u64 is for kernel internal uint64_t
> and __u64 is for uapi, e.g. see
> https://lkml.indiana.edu/hypermail/linux/kernel/1401.2/02851.html
> 
> So in essence we (QEMU/s390-ccw) have to decide what to use for our
> internal purposes. And yes, u64 and this patch is certainly ok. But
> we might need to change the patch description

Ok, agreed, the patch description could be better. Maybe just something like 
this:

"
The types starting with double underscores have likely been introduced into 
the s390-ccw bios to be able to re-use structs from the Linux kernel in the 
past, but the corresponding structs in cio.h have been changed there a long 
time ago already to not use the variants with the double underscores anymore:

 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a

So it would be good to replace these in the s390-ccw bios now, too.
"

?

  Thomas


