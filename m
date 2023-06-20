Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C0973623A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 05:41:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBSF0-0005fB-7g; Mon, 19 Jun 2023 23:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSEx-0005Xv-CK; Mon, 19 Jun 2023 23:41:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSEu-0008Gi-EB; Mon, 19 Jun 2023 23:41:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666ecf9a081so3003167b3a.2; 
 Mon, 19 Jun 2023 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687232466; x=1689824466;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xvk3u73onqtpjd8Pgu8MN5iX9aAoq9h8tykvTgZt2mU=;
 b=Zvt68d06xjp8QafzyucaQ+He4ZDkf2sdhb33sewdM1JASWDpfdJaB6POSNlXiIoQZo
 Mj7hGTx6xVxro9I2QuAD8nIwLBND7O8ntEv+qB6n/XwGpbvhxaIIXr/7f/Vba1SYsaxF
 bv7VuKx+1JgWtOj4rzVZSav0DMpOhaLgc3QMmjQqm2XRP/Y+pHZi/O56V2k90BNfW3Ko
 ZguAfcpNvg0u/YutyGZ4spyn8bnM0AnfQ8q+9pMIf2nA1jI1WYKsvEDtqJf9fwtV0s6t
 BSm4Bseg/iawMvP8OPC7X2OEoMsd1TR6pJx1oZLf+rxRojeBPVQXSourF9aOUKmM+zOp
 BriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687232466; x=1689824466;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xvk3u73onqtpjd8Pgu8MN5iX9aAoq9h8tykvTgZt2mU=;
 b=cAB8zK/AJSUZWmbBe7NAi9hJ9RhmnHqoy2+o6MNhMmHzFUrt+TAG5/wDnM3eD+M3RL
 8OqIE2JMOr16lf8QpZPl5FNEgzd2q1d9ZXBNq/KHLVuEIUy9nVzek7WsOG1vS9QQDVMz
 O5lyEygBnv91rSr51l+87K1IeFtOkba0qIpqYmFirT4/1z3uD7W4K/JR5FPg9FPW6vVU
 Qn/VaYTHCB2QqANMDPEa2kc5oDQW4i/2SBUoTWJuJ6rlxBCz74cHX+Smqp9BA/3+s1jy
 Id1q2/26u5I636KA5ZfzCKt4kO81jEZpYIuT/YztnPkTdfAEx+wJ6/95fhyCNjTyUTzE
 9VaQ==
X-Gm-Message-State: AC+VfDy/XbUbONdb/P4PMlbeUAu4qEtPr+PrLLnK955qbbDoIbl/33Li
 btpcODb3BZPFn05ch9MQxDg=
X-Google-Smtp-Source: ACHHUZ7wjY6Wwo1xzKU2QrR+uuEveCO6FWkIjJjXrhQx/C1d8nydQUZpRZv3QqlIxC6MibS7kdgLSQ==
X-Received: by 2002:a05:6a20:8f17:b0:11f:66a0:c9d1 with SMTP id
 b23-20020a056a208f1700b0011f66a0c9d1mr12952118pzk.46.1687232466386; 
 Mon, 19 Jun 2023 20:41:06 -0700 (PDT)
Received: from localhost ([1.146.105.3]) by smtp.gmail.com with ESMTPSA id
 c16-20020aa78c10000000b00653fe2d527esm356111pfd.32.2023.06.19.20.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 20:41:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 13:41:00 +1000
Message-Id: <CTH5ZNVFOSL2.Q42839O8BVBR@wheely>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/spapr: Move spapr nested HV to a new file
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-5-npiggin@gmail.com>
 <ffe96bb1-dee9-2736-68db-85e37a65e1ae@gmail.com>
In-Reply-To: <ffe96bb1-dee9-2736-68db-85e37a65e1ae@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Sun Jun 18, 2023 at 7:53 PM AEST, Daniel Henrique Barboza wrote:
> Nick,
>
> Do you plan to send a new version of this patch with a spapr_nested.h
> header included? Otherwise I'll pick this one as is.

Hey Daniel,

I'll send another series shortly with the header split out.

Thanks,
Nick

