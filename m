Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A575DFC0
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 05:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNPbd-0003Pg-89; Sat, 22 Jul 2023 23:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qNPba-0003PS-U8; Sat, 22 Jul 2023 23:17:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qNPbZ-0002SW-9d; Sat, 22 Jul 2023 23:17:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b8baa836a5so25535155ad.1; 
 Sat, 22 Jul 2023 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690082275; x=1690687075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6g+MrmFFSUWmTterYXpd9ROg2UwXtTN6hBwmzywpZX4=;
 b=oVfdwO9K06Ntr7TnVZj1LrEfbsb8Mxkd9WYnSo/od4VLSFj3kjKIF9b47Z9JNVfMZy
 N56XK2CFo9wpRYBp0HGR/BEVguLKNCI4RF3iwBxNub76wMVuOFDdu1jInOJXqexadYni
 fJwo5whiK4lSYEXzRuhnbDdLam9fe8sGwfGGZE3RMnmioVIBgt+nb9H2Topixlbv5U3B
 jmzTrCfkCNAK0KF6LxI6sRMJNRshZIKIwjsgzbimQ6uplz5PVok4DrMIrd6+LCGw0Kkj
 ZGX+mEgrfBSd86n4gb3Tz8Vxbe5uPsbWU/7awWRyrXoXHPAvGDBjfF/l9sVEYd2fmcr9
 I5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690082275; x=1690687075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6g+MrmFFSUWmTterYXpd9ROg2UwXtTN6hBwmzywpZX4=;
 b=be2cheLlGwNdinddiVw/eLctWzkuvApMuJVUuXhLw8WwC4hY9tGWeks5Q5RpOAsKAr
 tdivn3OjmPa4RV8mt0m1KIVoQyRutwhEo0GN3HqnMsLsGSHnJnIrtwar2xmViyb8biW4
 5WdWz74LnbWB2Gcur+GRsaPkcbUOMLBrTxdnVr/16/0Jb6X6syEisTYPMDsnC/l4IpZh
 MlHqPt88pPCUdMoyArk63T6cDn1jYvgvCp9eUU3ydIdewXtRCP0r4DtyGsDTfZPU/byY
 N1+UX9eMmPummpKHD0PpTOSGMxVYLTEL5BUqi0tKHCwoexoDTZIg5JczahSJNg0MIwAf
 cI/Q==
X-Gm-Message-State: ABy/qLZqFr26aC4L1AO+lI7w/y+pOZr8WjroaSKNydsO90hd8LMv8GMY
 G2b/e2LeCJhZgmxa8elJHBc=
X-Google-Smtp-Source: APBJJlHnq82JFkZxGacAOPt0BbffkA0PMk1bbk1qzXjzDlrMr1V5Bek4xnHlJfDH9ignJtp80PB/oA==
X-Received: by 2002:a17:903:48c:b0:1bb:59a0:3d4c with SMTP id
 jj12-20020a170903048c00b001bb59a03d4cmr5933902plb.22.1690082274963; 
 Sat, 22 Jul 2023 20:17:54 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170902854c00b001b8b26fa6c1sm6053721plo.115.2023.07.22.20.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 20:17:54 -0700 (PDT)
Message-ID: <d8e08f78-e294-ec51-63d6-b4b3588660c0@gmail.com>
Date: Sun, 23 Jul 2023 12:17:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 philmd@linaro.org, thuth@redhat.com, Jeuk Kim <jeuk20.kim@samsung.com>
References: <cover.1689899435.git.jeuk20.kim@samsung.com>
 <CAJSP0QU6Y0rDjb8Uy5KeST0kLfrAk7Hh8BKkoTnQ3_YhWyWSpQ@mail.gmail.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <CAJSP0QU6Y0rDjb8Uy5KeST0kLfrAk7Hh8BKkoTnQ3_YhWyWSpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 7/21/2023 8:01 PM, Stefan Hajnoczi wrote:
> Is there a test case along the lines of tests/qtest/ahci-test.c that
> exercises this new code?
> 
> It's important to have at least a basic test that initializes the
> device and performs a write followed by a read to verify that I/O is
> working. This will allow the CI system and anyone who modifies the UFS
> code to check that the basics are still working.
> 
> Thanks,
> Stefan

Okay, I'll prepare patch v7 by adding tests related to ufs 
initialisation and io tests.

Thanks,
Jeuk

