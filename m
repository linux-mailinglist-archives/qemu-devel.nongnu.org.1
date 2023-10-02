Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 183707B4A9D
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 03:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn8AR-0004tV-Pw; Sun, 01 Oct 2023 21:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qn8AQ-0004tG-0U
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 21:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qn8AO-0000MJ-IP
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 21:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696211770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4m1gZ+fChRS5OH2z/GG34bcXw7lGqRFJeKnL2545Mgc=;
 b=Bmht3Rtdu0GxWr0alBmp5NG2X8iLRCXFvyMpvg/Zj0CRZtVwwUtRXUP2EdJIC6TrJFq4iZ
 +tdKRYLV6uW0Bb4molDB7lzmRgRGBV4sWwWvXTHRVNe3x+cFKQitmW6fY5RiovW1L1srNu
 7mog48jCYYqpCaUNwfJLHBdO1tI9B/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-_ZA1xUpVO-qC9EDaPF_eAA-1; Sun, 01 Oct 2023 21:56:06 -0400
X-MC-Unique: _ZA1xUpVO-qC9EDaPF_eAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E9A33C11A00;
 Mon,  2 Oct 2023 01:56:06 +0000 (UTC)
Received: from [10.39.192.60] (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D9E170E4;
 Mon,  2 Oct 2023 01:56:04 +0000 (UTC)
Message-ID: <2d361bac-9f8b-0a3a-ddd0-f66cd1294159@redhat.com>
Date: Mon, 2 Oct 2023 03:56:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <90e566a6-2ac9-5adf-233c-085df81526c0@redhat.com>
 <c1ed25c6-1493-a1e2-b539-664bdb7d4127@redhat.com>
 <20231001152422-mutt-send-email-mst@kernel.org>
 <20231001152519-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231001152519-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/1/23 21:25, Michael S. Tsirkin wrote:
> Not this actually - v2 of this.

Thank you, but:

- Stefan's question should be answered still IMO (although if you pick
up this series, then that could be interpreted as "QEMU bug, not spec bug")

- I was supposed to update the commit message on 7/7 in v3; I didn't
want to do it before Stefan's question was answered

Thanks!
Laszlo


