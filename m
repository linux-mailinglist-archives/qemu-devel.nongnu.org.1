Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D98120F5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:54:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDXAC-00064Q-Vi; Wed, 13 Dec 2023 16:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rDXAB-00064A-7R; Wed, 13 Dec 2023 16:53:07 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rDXA9-0007H7-Pi; Wed, 13 Dec 2023 16:53:06 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ba0dfc9001so1749576b6e.2; 
 Wed, 13 Dec 2023 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702504384; x=1703109184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q1nyHHzwXQTSdRDlERdqnJMXhDgcP4HFTlJbhRnYppI=;
 b=QfKn5AtEBRQTke+hFRvqzLLXP06lk3VMxs7gtH/tl3uEjL+5Of4iGE8o+B75WZB/HA
 4PB6OhpjQia9xEdK2Olg3kOLe+Uf2+NqGrYeGRNSSnz7ZbG6x0eTF+8MIV99uENQoljG
 ZDL/hEZhvnx+fflOEXyHdXf4TWr8+rZ6RFrfT/Z4d7LtV9lIX/PmOKHM61wFkE5aqc1N
 axDtEaMaoD3C4kKlEtmzKD8kcAt8jd3TWt9fYK7wmMchrmCCej+KzOcyZdyDHY2Elq//
 G//oA+UEm1cIEFBpuQalj+GgvUcYe/6shCfi+3/oZ9iifLCBVH5JhbV6w+EbTfQC1T4q
 4bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702504384; x=1703109184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1nyHHzwXQTSdRDlERdqnJMXhDgcP4HFTlJbhRnYppI=;
 b=Mp3+rmGhiUuIPerkX/9XlGsfq9o9u/TU0qX9R5BskjM/vgz+YQFCMBqLnLmQi0sN1j
 2FvOwr1TiakuWQeWPDPqOc5JJgKNCjCrklmd9oewyka/QhbJ7qFOAF6oRfrz5JyYf0LX
 Tb+SQ5U7R2f7JX+hBazYW7HTqcYANs2xriIGWlJhoPuDQ0Ifcf6IRxio7Ub5uYCNPK5R
 hTaGGTQ+DbWE5PfuXnnQ9ISyQ+WNFWl3X3PzzwloR9Fju0xAC4pVvj/VjipxiYS9zw5l
 oE4arHW9JBmSAY+wOej/froo+4wjKN3NjWkAYNMSkSWbS/i9ov2LoPXyxeOhJF7VInbV
 KoWg==
X-Gm-Message-State: AOJu0Yz6Lv5hwwSluKN0C+ykoO4cxwcq42r0UV9EpM58OdEBt9DRuTVK
 hayIYZ1fTQI8dp981VAscIkn09XvjZxdUkYq8Kw=
X-Google-Smtp-Source: AGHT+IGnnfETAG4aNlwlPxBZGoroSbCWkIM+8vVUPDYDUgOVUnsM3rHqTDl7QWFVRAveLMsy6daXLqkYKdpIRWNLTdE=
X-Received: by 2002:a05:6870:40ce:b0:1fa:e1c8:8bb0 with SMTP id
 l14-20020a05687040ce00b001fae1c88bb0mr5420860oal.28.1702504383936; Wed, 13
 Dec 2023 13:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20231213211544.1601971-1-stefanha@redhat.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 Dec 2023 16:52:52 -0500
Message-ID: <CAJSP0QUH_Bq+UZGsud1tFaU4oK2HkN+wuZhmiqH66sByZK8OPA@mail.gmail.com>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 pbonzini@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Fiona Ebner <f.ebner@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22c.google.com
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

Based-on: 20231205182011.1976568-1-stefanha@redhat.com

(https://lore.kernel.org/qemu-devel/20231205182011.1976568-1-stefanha@redhat.com/)

