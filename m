Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530F78E503
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY9q-0007eS-P5; Wed, 30 Aug 2023 23:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qbY9p-0007eH-G0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:15:45 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qbY9m-0002fn-QQ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:15:45 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso7062561fa.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693451738; x=1694056538; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dpQyDxKC3QwG9MvCu1UHMgG74BVGMJv7VFvFq4YAnbs=;
 b=BIYmbhrHutOAEX6yW7jE/IUysbcpXFQGpOZ4dE0Cm6THYQ1kYp6GnxkpEs+3R6XW+L
 NOpf358AbsYWdbidTpsliRN+ZYEd57gOQB8pB5d1eC1U78rzlt8f50hB5nNQmKJ20xSZ
 1WW81V+vuvMNSET9hMIWVdwMJ/mj/bG98KlFMz5Ykj3bxHPn8guNqBqFepgpAbbT/+Z2
 VzpEQVXivZHB+IGEXCh+SMua6ypTudRqep0esvGoDp4AN0nZWsxx06GirUpyJfn1/r/f
 /z8ggp9Z9VJ1b3vyrDhHn47e5eb7j0atHL2mBmAtWc+GwRwDlv9UDIpY9PWXNXxc20qg
 LD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451738; x=1694056538;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dpQyDxKC3QwG9MvCu1UHMgG74BVGMJv7VFvFq4YAnbs=;
 b=TvrUVggEpYqVe8OrnB2Cs7GAnkP75S32vL0ObkPKttwI/B7TKTyTHr0ney4zjmEiHf
 wwRSlFUgb2v6mozRjHMUh6W+paSa8PkyUsyWwaxF12UHluaATOLnWnsKKnXZMnw9PlN6
 Xlrhu4RLJLh1JasQDi6kaDSfsWpzlkDDYXTtSkXURS2HL1N/xuHnLfGn2cl2mwmb5KL/
 E57fTNJnC0fub8s9JRf8CJe7rvbvoW7++9CXcpm/OHQj3Pfap1FdTVL4VRiyf9JJRkZI
 iDbunjAg+1f0RA7CCpn+Oq72ZdjbtjouoF8wfWs7w1Xo3naGeg9/zO3gH27EKSekfEsJ
 yaOg==
X-Gm-Message-State: AOJu0YziAHpSxnhQN30LSc66VRZhFBZ80zoYLY+qP6RqC7m6D07gXgKX
 IQK+vZeUYAteXLO2QQIrCOpQdUNUcjKUxG8CKuCD1oABvN6f
X-Google-Smtp-Source: AGHT+IEByfYkLiEYXLXXYyVr/C6FFex0H/IYA1vRNrP6dv+jLUXMXELbs2asSditjHkmq+uSrnY6xI+3Sf8MBWN9Y20=
X-Received: by 2002:a05:651c:228:b0:2bc:b61d:44c9 with SMTP id
 z8-20020a05651c022800b002bcb61d44c9mr3046868ljn.53.1693451737827; Wed, 30 Aug
 2023 20:15:37 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 31 Aug 2023 11:15:41 +0800
Message-ID: <CAOYM0N0o2SdiaAqtBm5md4z_FQnnP2csPrapc+5L47Qcaiw3Kg@mail.gmail.com>
Subject: About "PC_MACHINE_CLASS" definition.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000470cbc06042f75b4"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000470cbc06042f75b4
Content-Type: text/plain; charset="UTF-8"

Where actually defined the "PC_MACHINE_CLASS", I can't find it in source
code, please help to point out the file.
Thanks.

--000000000000470cbc06042f75b4
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Where actually defined the &quot;PC_MACHINE_CLASS&quot;, I can&#39;t find it in source code, please help to point out the file.</div><div>Thanks.</div></div>

--000000000000470cbc06042f75b4--

