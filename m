Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE7725617
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nns-0003tT-4o; Wed, 07 Jun 2023 03:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q6nnn-0003rm-NI
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q6nnm-0002mj-CQ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686123713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ApXvAJKrto379+Ybd/7l7lnhrMpok1F5OLVTAue7IQ=;
 b=jLga+nWzDRzCWrMUK/JHWTl2hnGxtL1FNr3K6KzbnU98kXFA2uuTOdpFRKifvlLcjFdPWb
 WM++jWtqWSNtq+c8nSqplEQs64IiKC6qHduAqtnSzUEpwH0QTyewD2LbFputJnYY5jijMj
 kIqtGeS3vcXbFKiYiLatZa6Lm6Tw+bY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-1GaQdrueO3K0dE232bdqOg-1; Wed, 07 Jun 2023 03:41:44 -0400
X-MC-Unique: 1GaQdrueO3K0dE232bdqOg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-978876e43a7so20037466b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686123702; x=1688715702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ApXvAJKrto379+Ybd/7l7lnhrMpok1F5OLVTAue7IQ=;
 b=diAHmUnvgWGsTjsr/WDriP6OmfpWdJ/0pgJ0FbOzOH9BXmFIjvQ0AbglZoxC0A7tH4
 iT31Jca02FPRKjukPBusidaf8fQVNQox4jHKxC0EkNMi9JgURaJ4jpy0VKl477yiR108
 vvyhhJ8ZmFKoFgReBTh8t8EqSX8HFIXiycwYpulXZofBNWsnkfZkG/IJuvnvvPwkBs1h
 up9GhroWuSD3yZJcj4Spb3/9DaJ/lj6f/yWH/GIo7Rvfo/kvms1D+8/ky53ekRiv39w9
 886iCLVwGk6uICZ4oIMU8K+ZkLrCvy3zBUaL7/ZWeqUz/SRBRipWwwTid+ZWjuM9uV3I
 Ndbw==
X-Gm-Message-State: AC+VfDypTYKpIWNFAyg3zs6+OwBHFoK9fO7hiCdDOn4zggP5ag4aH3UA
 DIx2D1c/Yqs7DVPwyvmuCxiK9kCsicvLx/YtPtNkfMEKgBQPeEUdPei99fd720q5Qc5ARG44pnz
 0xcZI/W+psxFJ1oEyCJirN0c=
X-Received: by 2002:a17:907:7d9f:b0:974:1f8f:89d7 with SMTP id
 oz31-20020a1709077d9f00b009741f8f89d7mr4749866ejc.31.1686123702843; 
 Wed, 07 Jun 2023 00:41:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OxJqO164oyFYvhFTjham6HOK/AEJQDetaoG2b8TtgsbGpwxiC6VMe+x+4QcFLde06xBer2w==
X-Received: by 2002:a17:907:7d9f:b0:974:1f8f:89d7 with SMTP id
 oz31-20020a1709077d9f00b009741f8f89d7mr4749852ejc.31.1686123702539; 
 Wed, 07 Jun 2023 00:41:42 -0700 (PDT)
Received: from [10.43.2.36] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 rh19-20020a17090720f300b0094edbe5c7ddsm6623279ejb.38.2023.06.07.00.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:41:41 -0700 (PDT)
Message-ID: <e9efc1a4-b292-10a1-9058-76f7c8ac9867@redhat.com>
Date: Wed, 7 Jun 2023 09:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/10] meson: replace submodules with wrap files
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
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

On 6/5/23 11:52, Paolo Bonzini wrote:
> This series replaces git submodules for bundled libraries with .wrap
> files that can be used directly by meson for subprojects. 

Pardon my lack of knowledge, but even after I clone new repo and run:

  ./configure --enable-donwload && make && make test

I still see berkeley-softfloat-3 submodule missing:

  git submodule status
  ...
  0c37a43527f0ee2b9584e7fb2fdc805e902635ac roms/vbootrom
  fatal: no submodule mapping found in .gitmodules for path
'tests/fp/berkeley-softfloat-3'

Is this expected?

Michal


