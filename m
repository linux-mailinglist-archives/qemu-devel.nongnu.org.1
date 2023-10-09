Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E57BD490
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkwb-00062K-4s; Mon, 09 Oct 2023 03:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <janne.karhunen@gmail.com>)
 id 1qpkwT-00060G-EK; Mon, 09 Oct 2023 03:44:41 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <janne.karhunen@gmail.com>)
 id 1qpkwR-0007od-Lm; Mon, 09 Oct 2023 03:44:41 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c00df105f8so52864341fa.2; 
 Mon, 09 Oct 2023 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696837476; x=1697442276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P2twXwE4VFcpf1LjW0cdZu7HpEYkQOkBrrLfPXtrlNw=;
 b=M5YJuP9h1R4Us0zcx6GUR0654COMzev4XE/1RPj5aCHXNRHrR3KatlpqA42DFB/z81
 F87xAA+x6xVh/Wj8Bthl/I2V9ZV/ickVk4fPGhjVveeuf+Fc6AJoXNl8ykT/CGv/i/IF
 nnuiabAFUCmftW7IZ2O/pS6ssr/PmlsebOWClTxIIjyIg2S3LeqJYSh7rRs1qSgTsv7t
 CQ7hscqEA4ZOomicYNfbsOdWLadd97blrZJY9n84+vKb+eImrgRMe8a8gWlZZyK54jTD
 fXKK2hG/qFtufG/bDpFrI4v3PJJKRzTsCU2D/Z9Lz2YFD1uxF2xaKvh3JZSFKFdnCW+/
 y/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696837476; x=1697442276;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P2twXwE4VFcpf1LjW0cdZu7HpEYkQOkBrrLfPXtrlNw=;
 b=etU/v0t0ZQCrBmri3wzGn8ScNFTzmgVw/HEZdClK/ovimbfxSkzoNsYuOIDo7JyxST
 hWiHnqXU4nQSAX8EyXxHLk7SLdFJAau62Dn43XF0Sqs+1dPP9QhDMHNBMrlzl3oMv8LF
 wkQTiqFx8aYL0pYL/jwWEExa+L/I5jZCQaDJew6pe7uG4s7uEKyzStQDHFnPJMcv568i
 3jX1Xj5s1P0WFUS+SYs2qvJickeVidTdLMgF2O55ih2ZD4q+jTqnqFmIisJJ0NWHXe3T
 gNUc5g366maCkotmt9oLoHBnpQ3UJssvAaQjLr81ReqsO8Pl7/J1r4KPuEwOHWUzwE1P
 lLkA==
X-Gm-Message-State: AOJu0YzHMO+n7GdP8jOxaVOTs8JnHG45dn/esoLika1+FzZ9V/MEUWpY
 8kQ2jz5NClFqhM7PI3oK/YseF4sjff4tPo+lnRi3vE+ywFo=
X-Google-Smtp-Source: AGHT+IGXn9lr3GN+A+odtboOBdWuH5KsVnO03lPR0CGU7nGXzYMVZktWKUgX7Fl9qNzidgQBdRPi97SENDDyBC6lpMY=
X-Received: by 2002:a05:6512:32cd:b0:4fa:f96c:745f with SMTP id
 f13-20020a05651232cd00b004faf96c745fmr14167478lfg.38.1696837475966; Mon, 09
 Oct 2023 00:44:35 -0700 (PDT)
MIME-Version: 1.0
From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Mon, 9 Oct 2023 10:43:07 +0300
Message-ID: <CAE=NcrYLpeemYwiT+460n41SKkNpBPXrnrZ92ti3Q3mo3p5jOA@mail.gmail.com>
Subject: virtio via external shared ram
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=janne.karhunen@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I have created an experimental setup for Linux where all the virtio
data structures and traffic can be allocated by the guest from a ram
blob outside of the guest default ram space. That ram blob can be
hotplugged to the guest or defined via the guests device tree.This is
done as some hypervisors, including tdx/sev/pkvm and others, would
probably benefit from a simple security policy that removes all
set_memory_{encrypted,decrypted} calls to open up the guest dma memory
in fragments that are not only likely to leak information due to the
widespread use of the DMA API but also slow things down for no obvious
reason. From the hypervisors point of view the fragmented shadow page
table space is also an unnecessary slowdown and a source of memory
waste.

I have seen forks of SWIOTLB that do similar things, but fundamentally
they are still SWIOTLB behind the curtains and as such unusable for
low latency / high bandwidth applications due to bouncing (copying)
data back and forth into those external buffers. The setup I have
created can act as virtio as it was designed to be, a zero copy data
transport path.

A trial integration into QEMU could probably look something like this
(in virt.c):

..
    emem_map = mmap(NULL, EMEM_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED
| MAP_SYNC, fd, 0);
    memory_region_init_ram_ptr(sr, OBJECT(machine), "ext-mem",
EMEM_SIZE, emem_map);
..
    emem = g_new(MemoryRegion, 1);
    memory_region_add_subregion_overlap(sysmem, emem_physaddr, emem, 1000);
..

So the question I have is that did I understand the qemu RAM model
correctly and would something like that lead to known issues
somewhere?


--
Janne

