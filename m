Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8D774BA9
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 22:52:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTgi-0002cg-1u; Tue, 08 Aug 2023 16:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1qTTga-0002cH-F0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:52:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1qTTgY-0002pA-Jf
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:52:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so191645b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691527928; x=1692132728; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=bSKkwhdpLh/nnW86dzL18ZgpQUgswlv3SlQVDzBFYAM=;
 b=ykD3gQhzhX1pV3f1AQ0zTF1p8ZgsAJlyCvDBr0G4LI7sAj2gGNHb2IyRVJM6tn7ra2
 EIZN3bnaAY3LZJnH+GQLVpsJ81o/sKzc4DTDKtOU5RhaZEgeRVZslmONCJDYio2Pgdcd
 jbjbHsp1cb0joXenSaP1DMbulF+k/7LbNxpK1wLv+MJ5MUkhli3v06B2KLZKMw3B/rBf
 nZrjYxVciAw2uKLqfAth7pueiy+40iurEVlA+UrMU/aaxn2Ubu0WTpWLkNg/+BNtEGkq
 DPfjoR+xUkTWxyq+heY7o4wQ41Docj3+qGYojAsbM9uB3GrpMOqAXUQ4ynDhNNBNft53
 VhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691527928; x=1692132728;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSKkwhdpLh/nnW86dzL18ZgpQUgswlv3SlQVDzBFYAM=;
 b=lIm+OtjZ65X2f4OVx7jzrXmxwtlPzFF2XChcOztXr1Vvlvjz0pSzfyrma8dxI4uqY2
 vxrN4ox8VxgeoN6MCC9tiFOIbCfvme3kHLw6YQ7ewXbUSiVOEAjJ9L0oEhgIfiPoOPeE
 Gb6wyKDtUDdr/LegmmREum5RYTV24p+71t3ktWRRhPqgADIxwG8w2U7YRbTAuuS6R0xB
 PJXqrtVVPuZocu4PKekfPnERpaD0m0lynTIPT0nLzVVG9hyUN4OTJ6W4ExXgGK5kve9I
 1Fv2S1ckfJT4fetEJoqukE4tNUvfsPprJi/Wjn+xX36/1MKBYBHIgMQsdxUy7wNSd8TD
 F+EA==
X-Gm-Message-State: AOJu0YwWXvXtKXbvCh74Go8zeNaFLm7r5VSFgwYVlBYdhom7plXRYvX6
 DfL0JrOB8KoxUnHt/qFbV8JO2g7T9pJuAHnRJ40=
X-Google-Smtp-Source: AGHT+IE2bx46EEVIgjd8fhbe7L2qJfjEal+FFtlpPuvTZmM9ytzOVqVrwQvOjtS/A+4lUaCqe8MiNA==
X-Received: by 2002:a05:6a20:3d82:b0:140:3775:308e with SMTP id
 s2-20020a056a203d8200b001403775308emr1175541pzi.0.1691527928548; 
 Tue, 08 Aug 2023 13:52:08 -0700 (PDT)
Received: from localhost ([50.221.140.188]) by smtp.gmail.com with ESMTPSA id
 l24-20020a62be18000000b006675c242548sm8448199pff.182.2023.08.08.13.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 13:52:08 -0700 (PDT)
Date: Tue, 08 Aug 2023 13:52:08 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Aug 2023 13:52:06 PDT (-0700)
Subject: Re: [PATCH 1/2] riscv: zicond: make non-experimental
In-Reply-To: <9fceb378-f079-e9ff-b8fe-da05b51fc1e1@rivosinc.com>
CC: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kito Cheng <kito.cheng@gmail.com>, jeffreyalaw@gmail.com
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Vineet Gupta <vineetg@rivosinc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-c8c16500-b5e6-4246-be18-849b74753d4d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=palmer@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 08 Aug 2023 11:45:49 PDT (-0700), Vineet Gupta wrote:
>
>
> On 8/8/23 11:29, Richard Henderson wrote:
>> On 8/8/23 11:17, Vineet Gupta wrote:
>>> zicond is now codegen supported in both llvm and gcc.
>>
>> It is still not in
>>
>> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
>
> Right, its been frozen since April though and with support trickling in
> rest of tooling it becomes harder to test.
> I don't know what exactly QEMU's policy is on this ?

IIUC we'd historically marked stuff as non-experimental when it's 
frozen, largely because ratification is such a nebulous process.  
There's obviously risk there, but there's risk to anything.  Last I can 
find is 260b594d8a ("RISC-V: Add Zawrs ISA extension support"), which 
specifically calls out Zawrs as frozen and IIUC adds support without the 
"x-" prefix.

I can't find anything written down about it, though...

