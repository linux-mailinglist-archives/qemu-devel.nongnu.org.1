Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9385F101
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 06:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd1mf-0008RA-Rj; Thu, 22 Feb 2024 00:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rd1mb-0008R0-Pi
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 00:38:09 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rd1mZ-0003Fq-B7
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 00:38:09 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-58e256505f7so5180059eaf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 21:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708580285; x=1709185085; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Yyk1L6RtKlcLBgwref1ORr8wkXexbBk3K7rMyHyazCw=;
 b=iTOnWWRulxqPViWv59nw/K0prJ6Ccy58+wFjQ5Ye9KmRLvyl0b26G8/rr6S+/xODA4
 o9pIR6sxA2303ECT+0hJVI6+sf7AdlveU1vVs2NR/M7b0Qob86lulw5VXrRFB3yVOYsT
 QMjllbiVVL6JZ34EjTBQyDrqPbTGSnbjZMg/Fvko51Y5IM+3Mxgf8mKUrwTNq2TKchnt
 tsRMrUMFgMqVRGf+V80JwcSmvD3mIbL8w5XUB+f6IzdrL+cEuG/DOgh0VCNPqRmTzaEV
 AVZGlwxqzSMReVtWG7Q14gEM94d9m7vnhqtFZaY0TQh+EI2z/9oPc1C1ZuEjYooeqcx1
 Iv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708580285; x=1709185085;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yyk1L6RtKlcLBgwref1ORr8wkXexbBk3K7rMyHyazCw=;
 b=PLUCBufJnLk86zeNuZNQ274R0TUfSO2payaA8dx4dO5P8NOqSzim1p4LKHM9cbVanI
 xkSZLHnhWQMKa6VGstqSTKqINvEZM/CcbGA7kB3zM4VKBIr2bq7h0vIAMiMPouYverq+
 6B7tL6BTifqqzpvZPuk9sOqAh7iNYbX/3keEkJFQ2fsw0sUauD9VjfuIuBCWYbL3H1zL
 4rVQKNkFkVjIhb+QmgubH7hrIwRAx1iBl7cQgjWo+RicEkb39BClrU7l1IoVE4tRui+Z
 R+PD6/Ip4EDGqFxXFXJ1xF7w5M7dW7A1P+07JnRHvHutCWzfZAr/oo9QA3yQ5QfQzeEy
 Iylw==
X-Gm-Message-State: AOJu0YzHQ1oKEGp1Wd2kN3aIvWSijUmTKDfEf/afwVQB/0EWLFte4guF
 MQmmRIKrxOAWxDBcbb6HRmurntYNrgCkerUPyMt2hV+ZiwGCJS9kkC3laC+RRrS0LdFcJZcDBr8
 ghaOhV8wrOlIYG546CuK951jot7wsI1vzpEcNKw==
X-Google-Smtp-Source: AGHT+IF4QLmIK+oi2QLI/xGAifZCAOivivs3x8qyIuLBGFfu1XyDrhrmvINFIj7s/qajP4kFrVBrKbThSzWf2VTLpwk=
X-Received: by 2002:a05:6871:750c:b0:21e:9236:a37a with SMTP id
 ny12-20020a056871750c00b0021e9236a37amr15062687oac.34.1708580285388; Wed, 21
 Feb 2024 21:38:05 -0800 (PST)
MIME-Version: 1.0
From: RR NN <rnn59437@gmail.com>
Date: Thu, 22 Feb 2024 09:07:54 +0330
Message-ID: <CAK4oD7DS0WiZcze37b8ERh50_ht=HNS3Bk8aeRmCjx_ndMG1gw@mail.gmail.com>
Subject: Support Android hypervisors
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fb1a8d0611f1d8ff"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=rnn59437@gmail.com; helo=mail-oo1-xc36.google.com
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

--000000000000fb1a8d0611f1d8ff
Content-Type: text/plain; charset="UTF-8"

Android Virtualization Framework (AVF) supports "KVM(pKVM)" also Qualcomm's
"Gunyah" and MediaTek's "GenieZone" as the hypervisor. Please Add these
hypervisors to QEMU.

--000000000000fb1a8d0611f1d8ff
Content-Type: text/html; charset="UTF-8"

<div dir="auto">Android Virtualization Framework (AVF) supports &quot;KVM(pKVM)&quot; also Qualcomm&#39;s &quot;Gunyah&quot; and MediaTek&#39;s &quot;GenieZone&quot; as the hypervisor. Please Add these hypervisors to QEMU.<div dir="auto"><br></div></div>

--000000000000fb1a8d0611f1d8ff--

