Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681627258B9
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:55:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6owD-0007dh-NS; Wed, 07 Jun 2023 04:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q6owB-0007dU-CE
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q6ow9-0006ez-OF
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686128076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sd1AZ9dT07AteIB0l85LNGEMYjriUxGMzzzEvDBsOlY=;
 b=We1jKD/WV3soL0vpmNfXo28m6z4V21ZCHT9nLIiDURmIq0rU8W6IZUi8vm9fke9W1sIcds
 SxMFuYzv1g5oai2nhB5loeNlfyFhSjgKpO1qCLfp8Sxsg4oGv6/KsnWs5zqjG30aJUPCCJ
 SY5OBRZpoGZwGSTp/GAbmyywe/rHAVo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-VSB1P9WTNRCkGApTg5_Zdw-1; Wed, 07 Jun 2023 04:54:35 -0400
X-MC-Unique: VSB1P9WTNRCkGApTg5_Zdw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-977cf886f17so298226466b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686128074; x=1688720074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sd1AZ9dT07AteIB0l85LNGEMYjriUxGMzzzEvDBsOlY=;
 b=QtvBKlR6MtVCIHQDxphRGLLOyLkEOtLeZy6N8szQTs1D4zOKnWnnm6O81MM3PYsBSC
 H1gMhiqn/Y+Hy4ho9zd02VNl40cIh/rVKbfDaQFsNnTeK7zu3oiljHr5aVgjJanRyd2a
 w8VSDkyjM8KzmhHFBHRXza5h+PkyhtFvEO7WbfERg6U0q1gjGyfS/sc6PgopnhSc65zj
 EMAdENEr66+3oyXJPM+XI6ZaetLE1S43qZRXsV+DtfnUdWPIY/3W3qBea4vKATmyaYHT
 xUr/+zuoq9Gt3ZPROPhl2Yp4PKgilzMxL09bInHj+zCpeL756KBYexfLPN19hVbLHOFZ
 zqfw==
X-Gm-Message-State: AC+VfDykS8hbMkXSdMhzZU4QPv/MBTnlOVXdTzodfvnpwQ9pBDdOPE2t
 xLGZamfS5jOggwoVHnJ06Jy9gHqpzANUolCoKQwiKSw/tRlmacS1WJR8bslTxbq/OIiwxiE9uhy
 pPOD+zy3Yw6KRbSM=
X-Received: by 2002:a17:907:e86:b0:970:e80:e29a with SMTP id
 ho6-20020a1709070e8600b009700e80e29amr5565075ejc.68.1686128074184; 
 Wed, 07 Jun 2023 01:54:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52T5oPjLoIAxkXgS1VERVTctabEsjgZFD25s4+I+zbXVFGWw32LnK/D2cx+jmht9BQtQ/8fA==
X-Received: by 2002:a17:907:e86:b0:970:e80:e29a with SMTP id
 ho6-20020a1709070e8600b009700e80e29amr5565057ejc.68.1686128073813; 
 Wed, 07 Jun 2023 01:54:33 -0700 (PDT)
Received: from [10.43.2.36] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a17090617c300b0097886136c02sm351097eje.151.2023.06.07.01.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 01:54:33 -0700 (PDT)
Message-ID: <a629ed09-1bfd-5ead-9b18-089d74f67e95@redhat.com>
Date: Wed, 7 Jun 2023 10:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/10] meson: replace submodules with wrap files
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 thuth@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <e9efc1a4-b292-10a1-9058-76f7c8ac9867@redhat.com>
 <ZIA1/5KQC15t47Sp@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <ZIA1/5KQC15t47Sp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/7/23 09:47, Daniel P. Berrangé wrote:
> On Wed, Jun 07, 2023 at 09:41:40AM +0200, Michal Prívozník wrote:
>> On 6/5/23 11:52, Paolo Bonzini wrote:
>>> This series replaces git submodules for bundled libraries with .wrap
>>> files that can be used directly by meson for subprojects. 
>>
>> Pardon my lack of knowledge, but even after I clone new repo and run:
>>
>>   ./configure --enable-donwload && make && make test
>>
>> I still see berkeley-softfloat-3 submodule missing:
>>
>>   git submodule status
>>   ...
>>   0c37a43527f0ee2b9584e7fb2fdc805e902635ac roms/vbootrom
>>   fatal: no submodule mapping found in .gitmodules for path
>> 'tests/fp/berkeley-softfloat-3'
>>
>> Is this expected?
> 
> Yet another example of submodules sucking. Once we removed the submodules
> from .gitmodules, git doesn't know what to do with the existing chcked
> out submodules from before this time.
> 
> Best thing todo is purge all existing submodules, eg
> 
>   git submodule deinit --all --force
> 
> and if there are stale directories left over, manually delete those too,
> so you get back to a more pristine checkout state.

I'm not sure that helps. I mean:

  git clone https://gitlab.com/qemu-project/qemu.git qemu2.git && \
  cd qemu2.git/ && \
  git submodule status

still complains:

  fatal: no submodule mapping found in .gitmodules for path
'tests/fp/berkeley-softfloat-3'

Michal


