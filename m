Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90C809D60
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 08:43:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBVUg-0003sI-BG; Fri, 08 Dec 2023 02:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aziztlili2222@gmail.com>)
 id 1rBVUe-0003sA-5c
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 02:41:52 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aziztlili2222@gmail.com>)
 id 1rBVUc-0003uF-Lz
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 02:41:51 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so594616066b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 23:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702021309; x=1702626109; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cIBCNJburwa1lXlaNI/lqz+u7u80GhDcso94KZrSyjY=;
 b=eEmJEf/oMl1yYoU2Ne4MPPXF0oSxGUmwqGddGlEfMrZWVUiYIHljbjZTUUJMrwJc72
 RAg6qeREYCh9PmVHm9r3XlfndJ5YwG9iPcTBJUKCRH1KurW6GbuTMq0DbJFxh4Yl0Axf
 IDuqghSUesGmPAAxnHjtIVJrUuw3Cro+t+3gYO0TP9aS4oPId4fTSq3K38Dw0PvRsh50
 snGJQBC/mAB2vw574Gh1Q6z91efPIPa3vpqzDER03sFdU5FEhPwsCCYvqDP7Q43QTWtq
 1akUf1OTcUNF0XPaTz0fp0X4GJlJHQ6NlLJxrNB4clMWl3J0rX4SgcEU3Y6iy/5Yp5cH
 igKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702021309; x=1702626109;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cIBCNJburwa1lXlaNI/lqz+u7u80GhDcso94KZrSyjY=;
 b=wo/iZV4U4ZwJPtUzgBWf1tkLZTPtlIuOGFjc+fpbvEtzJCJAlpToA94MBPSs452c2N
 BQVkDEVWesq4mgLhhIf+PSfE39NOFNAYJvJiq+7X3EmI4ig48eq4CJVMQFxTfOyZxcbx
 3Yv2qRn9y2Hfz0WN87VzbQsRPNZ7qarFx3UoB946DJujK4NB/yPdU9pUrFL4rWjCLIKP
 mJt3QMm01BrF/DTRCrsLEEhKbXmx8tFrndv6HpimhN6QhlJ4GHDAFVEt6sfEk58aRBNa
 Ww6Lro/9t4o/XQdfnenFwAAuNhsbkUSfWH//3XD0isdUq5bdMZ41aX1csDA3zP0id8mU
 B5eg==
X-Gm-Message-State: AOJu0YzPE1Ytf/pCtMdwYUIy+n1LmSCJivdlw4ZUdZJgy6oBtD9IDcPg
 JBrIZa9ILLC/jLMrRspKsAAd9KhRs4PG7JRMO/X3dg1E
X-Google-Smtp-Source: AGHT+IFxhwaf0D5f+wNDrKDa050ep1A1zzn3veWKdD2udFaIQaYMKxHd9k6q3YROQoSaR/fyZuxpd7rVj2tFPryyBqw=
X-Received: by 2002:a17:906:af72:b0:9fa:d1df:c2c4 with SMTP id
 os18-20020a170906af7200b009fad1dfc2c4mr478254ejb.36.1702021308631; Thu, 07
 Dec 2023 23:41:48 -0800 (PST)
MIME-Version: 1.0
From: aziz tlili <aziztlili2222@gmail.com>
Date: Fri, 8 Dec 2023 08:41:35 +0100
Message-ID: <CAHwHw5DtWyaxFJYNC2ygQc+ubJNGHqrdGgAwgRr+8tPhea+DEA@mail.gmail.com>
Subject: Kext files for VirtIO
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000080503d060bfab756"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=aziztlili2222@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000080503d060bfab756
Content-Type: text/plain; charset="UTF-8"

Do u guys have some free time to develop kext files "drivers" for VirtIO
devices (like virtio-gpu-pci and virtio-blk-pci and virtio-net-pci) for
PowerPC MacOS X Tiger (10.4.11) and later (till Leopard 10.5)? Please, I
need them as soon as possible!

--00000000000080503d060bfab756
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Do u guys have some free time to develop kext files &quot=
;drivers&quot; for VirtIO devices (like virtio-gpu-pci and virtio-blk-pci a=
nd virtio-net-pci) for PowerPC MacOS X Tiger (10.4.11) and later (till Leop=
ard 10.5)? Please, I need them as soon as possible!</div>

--00000000000080503d060bfab756--

