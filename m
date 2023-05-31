Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6B718DA1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TnK-0006bA-F2; Wed, 31 May 2023 17:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4TnI-0006ad-9Z
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:55:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4TnG-0002sK-9F
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:55:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso1381475e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamhpc-com.20221208.gappssmtp.com; s=20221208; t=1685570144; x=1688162144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p9hN+GasUWq9GS2O2l5PeojtXrBMEDLaxZBxIDYy9TU=;
 b=MafiIQhe8pKdRip4ujp2PyKt/9OkCzHVi1DLabjKydK/VnHjv5i3KRsZnismvwqCu5
 bfqAe90xcEEHgpDTJzfJfpvnyRJbzOK9uTT9vTkfRYFIgIOIiBguH2XwzNGZAbmO0lim
 DZk/OfVDrfZTZlle87ESRVBZsk/7sgijRkWeY/2yvohTZ3jMG1+1ZSJ3l0na3gwqxDYt
 luZ5NR3aQDS3tFoIGlZ4C6lgbJsAzhOO0X5JzYTghNuTNV+FMq1TNm430hzxmYBxwMNC
 JnU0gXzMyEn2JPgMKLS89UTniOklbA2MSAYY4i9mOIks57Sqc2tK4JCu+WVFLb9H3peA
 4liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685570144; x=1688162144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p9hN+GasUWq9GS2O2l5PeojtXrBMEDLaxZBxIDYy9TU=;
 b=ch6W/+rLfg8zaAtJBt+fRd2XzDEAF3K93Nwpen8oXBkzI+NJDbEFvn01rz39aA6WXu
 65z/ej57N6LgJe8ndLOdtXPs35O//a6Tv0lUcneMhLMCl63mrUkHUD19kPMzTSKILqDT
 bBLWAZIZVhNVYwoLQ1VMi5w+hVlphLqwM5Szc4Giemg1uHYWIWzJC2QpGrAlAJ/3G+be
 pAk7tvmmLF/GpLNa+tL++TAGuTpzxcfYJde5A9n0ob/EqgMhYdyk/TwgRNmKblwPWynA
 baZL7VJkDXvn4ibsv++9nET/+/GoB9fm+T0y4NgYrSJKxcR7UC2K6KFDbWMWlYI52f/X
 nP9g==
X-Gm-Message-State: AC+VfDwMLNA/5DJqOrhqH3sejqsR3b4VjEslTPkw6w2UzBrW/KVMejD3
 Pfn8rBSY7bbNlBMB+hKzqslkcA==
X-Google-Smtp-Source: ACHHUZ6uHw6KDifmwvhY4Ef6fUUEOp6IVVBzn2N5DyMflLJABCyHWDG5nJOOf8iiFn8sSUeevw90qQ==
X-Received: by 2002:adf:ef10:0:b0:2f9:ee8c:a2fa with SMTP id
 e16-20020adfef10000000b002f9ee8ca2famr236513wro.64.1685570143896; 
 Wed, 31 May 2023 14:55:43 -0700 (PDT)
Received: from [192.168.178.121] (dhcp-077-251-030-138.chello.nl.
 [77.251.30.138]) by smtp.gmail.com with ESMTPSA id
 j8-20020aa7ca48000000b00514971c293asm5093732edt.11.2023.05.31.14.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 14:55:43 -0700 (PDT)
Message-ID: <4301d6f4-a394-02e3-4773-823976b2e593@streamhpc.com>
Date: Wed, 31 May 2023 23:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
To: Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
Content-Language: en-US
From: Robin Voetter <robin@streamhpc.com>
In-Reply-To: <20230526231558.1660396-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=robin@streamhpc.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi Alex,

Thanks for taking the time to implement support for Atomic Op completer
support properly :). I have tested out these patches and the kernel
patch, and apart from a minor issue with patch 2 everything works fine;
ROCm programs that use device->host atomic operations work properly.

Something that I have been thinking about, are there any implications
involved with enabling this feature automatically with no possibility of
turning it off? I have no use case for that, though, and I cant really
think of a reason other than preventing the guest from finding out
hardware details about the host.

Thanks,

Robin Voetter, Stream HPC

