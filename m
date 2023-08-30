Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3278E32E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUWb-0002Hg-Ie; Wed, 30 Aug 2023 19:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1qbUWY-0002F8-DA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1qbUWV-00080o-Vr
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693437774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Tsy3LmzPrdu5P0qiQOX33Am8dWyeQt7PGfPhY+UZaco=;
 b=fjtDEKmQLJp69ehecXAl0nzJYgE37mC5OyF+9ARb347A9Acrl6JS8lpbzocRSLtN4/AxUB
 7/HHgzZpz3QH4EnS4qGiv0sXRhh/0eKduv+mAgxAfv+Fcq1K0N50kWvCl8cUepKytRe8cu
 IzqbvKRkUDhB3n8nPB99noDnOBY0Zh0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-r3ju4MTDPp-2r15uCY_eBw-1; Wed, 30 Aug 2023 19:22:53 -0400
X-MC-Unique: r3ju4MTDPp-2r15uCY_eBw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52be5604cdeso106949a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437771; x=1694042571;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tsy3LmzPrdu5P0qiQOX33Am8dWyeQt7PGfPhY+UZaco=;
 b=gZomNUEJ1Bg9JeUJFC2G9TtynBafyjrFclmli/J9Tu6wOlh3dnRlAgl/iwBWafbYI+
 +Lb1/L4Ng4JvQ6kW1SU1zXTWOz6h1lNP4aJ6mZ917cTmUYaC0ESbUpxylcB/upKw0e7D
 oniRoq1RcvwkQyxJrpov+kJZ8E6gJGXuGhjWnwL7w/grM9ULjFmMAWP+avQU4y0RJ1qN
 pSJ/b3FdhXC2ts1RGYM/KuKMk+bID7Wif/yrkvs0Lyggk0smcWsHECrbZG55OCjiIF98
 XbPCeD2Fq0SzsLSzxxltgqZdOJIihhNeaLmczOCEOs4fFHdwJoh3KHA7+T/Lecif2EW3
 7A4w==
X-Gm-Message-State: AOJu0YznTB3XlukM29yfn2EYIDyyA2XLZpRiPW/NKR9YX8WsVoxaKBBS
 Byu4q6OTRyZy10aJWPqnmO0zMUGAl52w8N0196KebCL7T45Pux1QRXRZVpLahtCN+krkiXZA+ux
 QPhM8d9XIBp6Yx8XGyRuR8+hTzz2B1QcfSQU4AUHwhg==
X-Received: by 2002:a05:6402:b11:b0:523:d1e0:7079 with SMTP id
 bm17-20020a0564020b1100b00523d1e07079mr2686734edb.21.1693437771599; 
 Wed, 30 Aug 2023 16:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8eoW3Hi+j/55wZMrl5/Mc+RkMFI35251SDVw61l4VBdwbEClooK1Ylv0l+fTVg5MAJX8iqnBNxTAPbrBluE0=
X-Received: by 2002:a05:6402:b11:b0:523:d1e0:7079 with SMTP id
 bm17-20020a0564020b1100b00523d1e07079mr2686719edb.21.1693437771207; Wed, 30
 Aug 2023 16:22:51 -0700 (PDT)
MIME-Version: 1.0
From: Alberto Faria <afaria@redhat.com>
Date: Thu, 31 Aug 2023 00:22:15 +0100
Message-ID: <CAELaAXwZWmhmFzUXu01g+_nZY0eSaqUeLQqGxbFAG-xFhHRmCQ@mail.gmail.com>
Subject: Announcing Subprovisioner, a qsd-powered k8s storage provider
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block@nongnu.org, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alice Frosi <afrosi@redhat.com>, 
 Alexander Wels <awels@redhat.com>, kvaps <kvapss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi all,

FYI, I recently released Subprovisioner [1], a
qemu-storage-daemon-powered Kubernetes storage provider that enables
users to provision block volumes backed by a single underlying shared
file system. It works by storing those volumes as qcow2 images and
exposing them as block devices using qemu-storage-daemon. This also
allows it to support features like volume cloning and snapshots
efficiently, by creating overlay images.

A solution like this can be useful, for instance, when one would like
to use a single big NFS share as storage for a Kubernetes cluster.
It's also an interesting use case for qsd.

Thanks,
Alberto Faria

[1] https://gitlab.com/subprovisioner/subprovisioner


