Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47F8240E6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 12:48:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMBf-0003Ue-Ep; Thu, 04 Jan 2024 06:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rLMBc-0003U5-IJ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 06:46:57 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rLMBb-0005hO-3i
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 06:46:56 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1f055438492so214969fac.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704368813; x=1704973613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AsjePC+bQDfq3CoX0JytM4KihuBKtazhLIrNkBPR8sM=;
 b=a5wqlJ0skiKeBOcL9N0qlZ/TrRBP6VSNboJxo6/wvMuHWntuHn9/LkOFkEre2RvYHl
 OGefMV6wuhHgNDebPcakgirO1VJp4nSIVPVSZ6EEMX8oSrHsklLrlDs/nxoBW2VhdMsL
 OZYDA3VA51iWe37hCNzQobeISRW0uDA5mNibjLxmNe2afmeWH0zEYgDOcrMsUba64vvF
 81CfBI1TNfeRx/IkdA4SzxjTMFN2/9UCUTH+XJuN0r9EbmE0cwUaYPaaN2rawXrVZxIS
 ZUEC+aTpyroMfHzOjXow/Ofs3Swi+hT3dsfo2htEve11W0aY6WzuiXdxlRdiQJVz+Z0Q
 XGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704368813; x=1704973613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AsjePC+bQDfq3CoX0JytM4KihuBKtazhLIrNkBPR8sM=;
 b=DpbpEJMFtUC/gARCxrOTtmJuVcpvhg/+pgUee7KrPKSs9sUD0vUcQfGyNzZxB1airv
 D9Ym7iX0FMGXEC9/bHp5sH+UJmuXLdvJns7tLG3OL5m7ZDpcJhkGABtGbh+5YRgTdZRE
 wktkyH47O2ugk62c0OqV8drhUIfzOFWVFbIgKFKPhR0F/Bzb2wmJFypECH0xWHPc7a7+
 JcaGDdrkJvXJ/I9m1UyejLIKheQwOh0cSfPCSzYaSKNerr8JTXuj473T7k+KAUb8MmsO
 X0yU/weU2c7jGDIdObTOro6qvouVrIgtl9TADJyIqIKP2tRtizFbNFBCqpnmRyNEQEfH
 7dIA==
X-Gm-Message-State: AOJu0YwJZuaUu0ylrUrCsZ8tB/kAVStY4CXmVSNLqPVcz+zTsIHDm4i9
 qvccZVTh1VKQge37FZfyoMZC7yFeTbnB43eJeXc=
X-Google-Smtp-Source: AGHT+IFt2wSQe1XBcVR0Ansz5q3imgJP9u1SuNId57G5kJM7uqe5niqchVeHa2SboSCXz6NVJNtvTpv1WuBinQ+PQ2M=
X-Received: by 2002:a05:6871:e48e:b0:203:eb66:3bab with SMTP id
 pz14-20020a056871e48e00b00203eb663babmr513723oac.54.1704368813285; Thu, 04
 Jan 2024 03:46:53 -0800 (PST)
MIME-Version: 1.0
References: <87mstno2ob.fsf@secure.mitica> <ZZS9-H2g6qjlY-4_@x1n>
In-Reply-To: <ZZS9-H2g6qjlY-4_@x1n>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 4 Jan 2024 06:46:41 -0500
Message-ID: <CAJSP0QWLzSuEkgNKQ=Yvw1VbGhoy-SNG+jiGg90jW3Bvmh7EHw@mail.gmail.com>
Subject: Re: QEMU developers call
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 2 Jan 2024 at 20:54, Peter Xu <peterx@redhat.com> wrote:
> If I'd make a list of good candidates, I'll probably be the last one out of
> tens, especially considering my current timezone. :-D

Does this mean you will handle the community call?

Thanks,
Stefan

