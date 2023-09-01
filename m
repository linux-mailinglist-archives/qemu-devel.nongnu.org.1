Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE8C78FF4E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5GJ-0005Lm-31; Fri, 01 Sep 2023 10:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qc5GH-0005JV-7N
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:36:37 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qc5GE-0006Am-Bh
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:36:36 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bcade59b24so1655278a34.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693578992; x=1694183792; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmqbsFxhSm098fRo48fHquZO45QvE1z2qCjg1TEAuoY=;
 b=cY+Tz/bzOfM4R6olb4XZTEGXVJaKjT8NTZkoVvsKsr/BKreuuBcbsgI1uiZtUOrpx6
 MktS49PdiZ7sL6oVAsVc7IRqU++CewC/AfcwMWclPqU6wj1XTsFKrwTviAacGqXAnGnA
 EUr9JlbwAgo0EqzW0LTVXY9grYE2UW5wM8uU3qiO9f6lWztORqb3ycCq+cs1RVIcsSJN
 ueZEWJxogb6QyLtUU06tRDLIMRwIZqBrRj69eoiTHKDYxsWtRzHzWiy+J/95RoGyPCyX
 VHtgIb3UADNjS3HULX+Xl8MoFKFPZoHm8/1Y07mSA/IBZwwRqWvfGJFBsoA928aiwkMO
 KpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693578992; x=1694183792;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gmqbsFxhSm098fRo48fHquZO45QvE1z2qCjg1TEAuoY=;
 b=RW7XY6QQA1WCv4fhhuzVAa+gw3/Oa5FJ21LTjmv6SbYTW5RRXlVIuFK5NTPlXwuMiE
 dqX6dulOWVgG/hLJPWFeiR8rz1hXNSYrTGQKX9AUaaEKrc2PtuE9nh4iFYbAktYtEZdZ
 3ySR6Zpt6+eijFeKzuSL+/GQ2dYM/Fw4k8rUGsrkeFX1IYABMiwGD6Hg/+xLelIPo2BE
 x1jQ7qhTZS4Auknf0svpoZigeN01DJSXVHernen76xJLhoXljMc8FpRJyfIcCl1nIn5Z
 CUvITAxxDLyQapBvUuDCNQp01DFKtUvL2kHD+hTZPlBkCjAdct7PddQhd5TSNnM4dAI3
 R7cw==
X-Gm-Message-State: AOJu0Yzuo+FAviVfybfzE0xXMIGGqnI/LBiey0q3Qli2GDzl+aYPV5fE
 6NteAbRkRHVEG9xpm4+1VGCs9APUDLzpLl7CNe4=
X-Google-Smtp-Source: AGHT+IG5W8m9U69lKvpJnA687zY/ybz8/XiGv3RncUHwoKLAsEfVCd7l4wg7a56EKGH2gM84F7OYLA==
X-Received: by 2002:a05:6830:1e17:b0:6bc:65ad:1b08 with SMTP id
 s23-20020a0568301e1700b006bc65ad1b08mr2615028otr.28.1693578992229; 
 Fri, 01 Sep 2023 07:36:32 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a9d6485000000b006b1570a7674sm1865262otl.29.2023.09.01.07.36.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:36:31 -0700 (PDT)
Message-ID: <eac059f4-72e2-d1fe-27b2-9657d1777e45@ventanamicro.com>
Date: Fri, 1 Sep 2023 11:36:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: 'check-avocado' fails after c03f57fd5b ("Revert "tests: Use separate
 ...")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

FWIW I am unable to run 'check-avocado' after commit c03f57fd5b ("Revert "tests: Use
separate virtual environment for avocado"). The error being thrown:

[20/20] Generating docs/QEMU man pages with a custom command
   VENVPIP install -e /home/danielhb/work/test/qemu/python/
/home/danielhb/work/test/qemu/build/pyvenv/bin/python3 -B python/scripts/mkvenv.py ensuregroup --online /home/danielhb/work/test/qemu/pythondeps.toml avocado
mkvenv: checking for avocado-framework(>=88.1, <93.0)
mkvenv: checking for pycdlib>=1.11.0
   AVOCADO tests/avocado
/home/danielhb/work/test/qemu/build/pyvenv/bin/python3: No module named avocado.__main__; 'avocado' is a package and cannot be directly executed
make: *** [/home/danielhb/work/test/qemu/tests/Makefile.include:139: check-avocado] Error 1


The system is a Fedora 38 with python3-avocado-92.0-2.fc38.noarch.

Reverting c03f57fd5b fixes the issue. This is also reproducible in a fresh git clone
in the same system, so I don't believe it's something to do with a dirty working
tree.

I was unable to quickly identify why and fix it, so for now I'll be reverting the patch
locally to be able to run check-avocado.


Thanks,

Daniel


