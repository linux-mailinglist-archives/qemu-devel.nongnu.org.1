Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C87672811D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FXB-000424-7R; Thu, 08 Jun 2023 09:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sagigrim@gmail.com>)
 id 1q7AGV-0000e8-OT
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:41:03 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sagigrim@gmail.com>)
 id 1q7AGT-0001Qr-LG
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:41:03 -0400
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2b1b1dd208dso199781fa.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 00:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686210059; x=1688802059;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yKU5vNc69NxvV6Esi6tQFzrZPbsCUaFoxSmjiLhp2c8=;
 b=jQVkCMybicRPMjpIbLlLhKZGkQG7aUu9CBpM4JMC0HfyoaONErRh1qDeRfSOV/OCpc
 RAF3qD5kdOES/gbZKuC0hNm6q9VjjQ+7tHuBTZsich8Zuvx4W1AiBh2CCxWp2uULH/ta
 AuXAhJqLNkTOt+ypKhAR2nKDLa/ZqHyLmN6ozZ28IMoNR3O8ajgQIttxm0gK606U7SsY
 7ZfoGeg5RHUkYd7W4j84HrXDu+4t9nxbAE7cW8HBPu6A7vASJLC/uDjGYlVL3E+7dqMZ
 vRwr9MvhdtPjtYowaEYYOCXTvpHR/L7qjjR6ZVmy2wB4KESyy4CMlcu/fDQCrbSmWF3x
 6wwA==
X-Gm-Message-State: AC+VfDzpeeG/FAHC9TRbdkzizxsBlqHwgXzxe1j4ACJdkZ+/N8WcVY/n
 +1p2TYEZBEr0Zm0qPEDMopf5DP09S5E=
X-Google-Smtp-Source: ACHHUZ6DFkMDyItR/Ggb4osv3Q36Z0HI3famIuN8nE3cR2XGsvA4htBAsp9upN133oQvs4laaUZ1sg==
X-Received: by 2002:ac2:51b1:0:b0:4f1:45b7:2e5b with SMTP id
 f17-20020ac251b1000000b004f145b72e5bmr2512260lfk.3.1686210059108; 
 Thu, 08 Jun 2023 00:40:59 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il.
 [46.117.190.200]) by smtp.gmail.com with ESMTPSA id
 r16-20020ac24d10000000b004ec84d24818sm92196lfi.282.2023.06.08.00.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 00:40:58 -0700 (PDT)
Message-ID: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
Date: Thu, 8 Jun 2023 10:40:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>
Subject: virtio-blk using a single iothread
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.174; envelope-from=sagigrim@gmail.com;
 helo=mail-lj1-f174.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 09:17:54 -0400
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

Hey Stefan, Paolo,

I just had a report from a user experiencing lower virtio-blk
performance than he expected. This user is running virtio-blk on top of
nvme-tcp device. The guest is running 12 CPU cores.

The guest read/write throughput is capped at around 30% of the available
throughput from the host (~800MB/s from the guest vs. 2800MB/s from the
host - 25Gb/s nic). The workload running on the guest is a
multi-threaded fio workload.

What is observed is the fact that virtio-blk is using a single disk-wide
iothread processing all the vqs. Specifically nvme-tcp (similar to other
tcp based protocols) is negatively impacted by lack of thread
concurrency that can distribute I/O requests to different TCP
connections.

We also attempted to move the iothread to a dedicated core, however that
did yield any meaningful performance improvements). The reason appears
to be less about CPU utilization on the iothread core, but more around
single TCP connection serialization.

Moving to io=threads does increase the throughput, however sacrificing
latency significantly.

So the user find itself with available host cpus and TCP connections
that it could easily use to get maximum throughput, without the ability
to leverage them. True, other guests will use different
threads/contexts, however the goal here is to allow the full performance
from a single device.

I've seen several discussions and attempts in the past to allow a
virtio-blk device leverage multiple iothreads, but around 2 years ago
the discussions over this paused. So wanted to ask, are there any plans
or anything in the works to address this limitation?

I've seen that the spdk folks are heading in this direction with their
vhost-blk implementation:
https://review.spdk.io/gerrit/c/spdk/spdk/+/16068

Thanks,

