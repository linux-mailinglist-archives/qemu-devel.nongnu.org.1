Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379276008B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 22:32:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO2CS-0003Jn-Tl; Mon, 24 Jul 2023 16:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qO2CP-0003JN-8Z
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 16:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qO2CN-0001AN-Qf
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 16:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690230630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNdJ3UXZv4iS9zG7y9HgySWNJ/gdmtnrvJgCCVdMfSk=;
 b=JtbmOFk8cB+ex/tcjw8pRYzAZVZVs5Iu4j5IRRgdsxsX7ttdvInaSbX3igpG08aQwbZs/t
 z4rg1/sabZEZt+AOHZr6rgX5xal3FPTFaU/y1K/7vh7u5PCORRXDaoyTB/5SwHxRVc2EN4
 5Iv6JSb4BSHi3wek58vtDRGtHtKU3k0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-qID-VYQ6OiecGK7WetrLhw-1; Mon, 24 Jul 2023 16:30:28 -0400
X-MC-Unique: qID-VYQ6OiecGK7WetrLhw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52231fa854aso829919a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 13:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690230627; x=1690835427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PNdJ3UXZv4iS9zG7y9HgySWNJ/gdmtnrvJgCCVdMfSk=;
 b=ONW/OC6ZBnQjwbfnIhyHjE1XY00ArFiKoFZys5VUBKXui0juldYS5IY0JfaLa94KQU
 Arv8cQjXOvohVpRkHEXoy+8RUH1F1MNgfv7vPBId66n0gGP5psYzvVzXsHNcYouJPmw1
 rlCbmVrPKiLsA1qWd4JZDzVMnFRTSLA9MU0BBEuo+TB6i5xArKdgy3Apjl4G0gixQcfa
 eE2+qRFOmkOfVZZim2XggzwGx+/Mcn32I84Z9VBFWgxBfKmIs8ulE5Omd+h45PFQFC3f
 dB0Y3kH1j8R87PO8p+bvrZaxq1dyNxB3oofkEQ4eXaR2QE0nIyelIZ9akvvsbMhuH017
 7GFg==
X-Gm-Message-State: ABy/qLaGRFRkRAfjqLg0RzUvSCaxP1wJOrwscPbMZYe0oEXFVRPT8r9H
 tSiKLNYMNFosWIss8m7hhZM4xe46pWaYkwWeiBIHozjHtK+Q03vFwnrgFPG40GxZ3+tokcrE4y1
 UobGyfr9DlXIinns=
X-Received: by 2002:a50:fb0f:0:b0:522:1e49:d52f with SMTP id
 d15-20020a50fb0f000000b005221e49d52fmr6066587edq.8.1690230626887; 
 Mon, 24 Jul 2023 13:30:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFM9N4TPoPg+ix5drhUNL5043H/TXJZgeZWDyAMu6DMMGhHhBI1BDQjoQyBrP7eYEXPXnE0oQ==
X-Received: by 2002:a50:fb0f:0:b0:522:1e49:d52f with SMTP id
 d15-20020a50fb0f000000b005221e49d52fmr6066577edq.8.1690230626566; 
 Mon, 24 Jul 2023 13:30:26 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 a11-20020aa7d90b000000b005222a38c7b2sm2484126edr.48.2023.07.24.13.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 13:30:25 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:30:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: Li Feng <fengli@smartx.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Subject: Re: [PATCH] vhost-user-scsi: support reconnect to backend
Message-ID: <20230724162933-mutt-send-email-mst@kernel.org>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <DDDB71EA-E549-4325-9CDC-E9C746AE2E9B@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDDB71EA-E549-4325-9CDC-E9C746AE2E9B@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jul 24, 2023 at 05:21:37PM +0000, Raphael Norwitz wrote:
> Very excited to see this. High level looks good modulo a few small things.
> 
> My major concern is around existing vhost-user-scsi backends which don’t support VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD. IMO we should hide the reconnect behavior behind a VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD check. We may want to do the same for vhost-user-blk.
> 
> The question is then what happens if the check is false. IIUC without an inflight FD, if a device processes requests out of order, it’s not safe to continue execution on reconnect, as there’s no way for the backend to know how to replay IO. Should we permanently wedge the device or have QEMU fail out? May be nice to have a toggle for this.

No, device itself can store the state somewhere. And if it wants to,
it can check VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD and fail reconnect.

-- 
MST


