Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9949821F0A
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 16:55:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKh5Q-0002Rg-8J; Tue, 02 Jan 2024 10:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rKh5N-0002RP-MF
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rKh5L-0000kq-Cl
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704210822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2T8Qf+Rc/p2DeRFaWU5MlQhWAd+xUeqS1O/gEC5fhw=;
 b=fJRANtgmyxCamhc0m2hlKJHXBeb4gSXg4Nm4oRt583nTz5icZTXhzu0/B4lpd/cudl/fVn
 /xmSbhoefuHrxZ+MZmC9nykbQWZp2nf3pU+7s8AFEAq2elEVuttM3BVEqmiIXa9kEm1JSQ
 aj+zY83E3S6CSOiZROVMpv2vgktu7yk=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-iRdJAXD2NVKrnQJ_haBDrQ-1; Tue, 02 Jan 2024 10:53:41 -0500
X-MC-Unique: iRdJAXD2NVKrnQJ_haBDrQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-466fbc8fd03so1679622137.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 07:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210820; x=1704815620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2T8Qf+Rc/p2DeRFaWU5MlQhWAd+xUeqS1O/gEC5fhw=;
 b=J9AGwRm/lbMYwpeWKJK8qcfQ5RIRgEGJMtKMxnmjjcTSp2YPRx9r2ABL9Yhmmg5e51
 Geca3KjvtSlx+uIGDeEj9IMy5PvhvMRiKbTZX4/sLwYjGTPDR6yk5dEELb6VxFoAOMk6
 oiBjrWsoLC013L/fDfKzNFfwCToFgX5pLnqy6+1x7+b1I21zvt8kO3eEQpqUZZHSQ1eA
 25zRVnnkdrq0Zw9PijhEnhoFDcEAeyOL/bMdL9TPcuSehJ4qwcmTRgGtJP2z+FQY6OIR
 oAdXsHzK87uK4+gh/vojDTURs+JFbQCqmP9FeTB+8Mw9sL6N5z2+emLULvLgR9vQgnju
 FIZA==
X-Gm-Message-State: AOJu0Yz0hOGycwbVdThqBjjAMt+avFtDAAHjyB2SPt9FJaRWc0wvt9Fo
 taKquCpw57iQ1roChvM6j/O/xXMfiwrAVCXqNlQvVm5rqOf+O7Yfxv/JOds4od6Sc+8acdi9KIf
 Aj85wDTRFJuW7qL4U0YOn1PgjFmrbdI7KDAbKLNA=
X-Received: by 2002:a05:6102:2d05:b0:466:fd31:def8 with SMTP id
 ih5-20020a0561022d0500b00466fd31def8mr6974809vsb.55.1704210820585; 
 Tue, 02 Jan 2024 07:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOZrLQP439NMzUqynwO73LTLKgiQ7x1EmL+N/CdoyonU/rHlGwOztoD3/7yGDnjJwUjH0wx2sjgDcfoG0xgYQ=
X-Received: by 2002:a05:6102:2d05:b0:466:fd31:def8 with SMTP id
 ih5-20020a0561022d0500b00466fd31def8mr6974797vsb.55.1704210820344; Tue, 02
 Jan 2024 07:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
In-Reply-To: <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jan 2024 16:53:27 +0100
Message-ID: <CABgObfZcB-0b7-dF1obyUqqdsgjy93d-1rGLaiExzRdZK9hHEA@mail.gmail.com>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Fiona Ebner <f.ebner@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 2, 2024 at 4:24=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> w=
rote:
> I=E2=80=99ve attached the preliminary patch that I didn=E2=80=99t get to =
send (or test
> much) last year.  Not sure if it has the same CPU-usage-spike issue
> Fiona was seeing, the only functional difference is that I notify the vq
> after attaching the notifiers instead of before.

I think the patch makes sense and cleaning up the logic of aio_poll
(which is one of those functions that grew and grew without much
clarity into who did what) can be done on top.

Just one small thing, the virtio_queue_notify_vq() call is required
because the virtqueue interrupt and eventfd are edge-triggered rather
than level-triggered; so perhaps it should be placed in the
function(s) that establish the handlers,
virtio_queue_aio_attach_host_notifier() and
virtio_queue_aio_attach_host_notifier_no_poll()? Neither
virtio_blk_drained_end() nor virtio_scsi_drained_end() are
particularly special, and the comment applies just as well:

    /*
     * We will have ignored notifications about new requests from the guest
     * while handlers were not attached, so "kick" the virt queue to proces=
s
     * those requests now.
     */

Paolo


