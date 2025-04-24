Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340FA9A3FE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 09:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7r4J-00035e-8f; Thu, 24 Apr 2025 03:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7r4G-000346-2a
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:32:20 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7r4E-0004wZ-4v
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:32:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CD3224AE73;
 Thu, 24 Apr 2025 09:32:13 +0200 (CEST)
Date: Thu, 24 Apr 2025 09:32:13 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Message-ID: <767155443.4848.1745479933168@webmail.proxmox.com>
In-Reply-To: <aAjcSnT_zYnuOG2W@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <aAjcSnT_zYnuOG2W@redhat.com>
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> > +    gst_object_ref(vs->h264->source);
> > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> > +        gst_object_unref(vs->h264->source);
> > +        VNC_DEBUG("Could not add source to gst pipeline\n");
> > +        goto error;
> > +    }
> 
> If you put the gst_object_ref call after sucessfully calling
> gst_bin_add, then it wouldn't need the gst_object_unref call
> on failure. Repeated many times below.

Gstreamer docs claims that gst_bin_add() takes ownership of the element. So I assumed that it unref the element in case of error.
If I do not ref the object before, this would free the object too early.

But a look at the source code of gstbin.c reveals that it does
not unref the element in case of errors, so your suggestion works.
I will change that in the next version...

- Dietmar


