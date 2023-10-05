Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 091747BA7BC
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRxH-0008Kp-Jp; Thu, 05 Oct 2023 13:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoRxF-0008J8-OY
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoRx0-0004xX-7s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696526147;
 h=from:from:reply-to:subject:date:date:message-id:message-id:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHfkpj3fWywle7lL8UYCo9hfDVCWPxeBN53mJaWdWgM=;
 b=U/0UJjj8xMYCrS4R2Jyu+KZiB+DfQfWUt2mwMBvrh5Iw7A1Q+xrRoOlHsPcUVLMrgxueUY
 TYJufBDjkl76wgXUTmD9j/D0SOkOPAZCE4l8lyoaCP0vIXS68mMWRof5e1kE6+chdbUlWW
 2Ne503m1EVAK1QB3/hncQJHbDLPC54Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-bVu-jJObPRm9dJGGk_Q2bw-1; Thu, 05 Oct 2023 13:15:46 -0400
X-MC-Unique: bVu-jJObPRm9dJGGk_Q2bw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso8274655e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 10:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696526145; x=1697130945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :cc:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cHfkpj3fWywle7lL8UYCo9hfDVCWPxeBN53mJaWdWgM=;
 b=ttyQtDTzHwrcDCaShFsPLRxYIY97y6nOqyO08yS4Af5LziY713XqpPyrZzBZ3Ki9os
 GJZVzJEamz10o+HVKZljkBrp4cBStZP85rsDukIjGhxCIXCQJwipk9X/LOuAXR0uL60G
 /EDDZRKvvE1l2HZwYIhH7gPX21WZxcxQ7dFJlhcj6VpgRyFz39hQUIGIAtswUnm+aA+5
 fBnBuG3m9Xl/q0dkUW5CNnbwzWjhj6nbVWF1MvXkFc63UTRBuPaNydOxgH6JS2YIaG99
 oBlHHqedTPCo1TLdfo1BrtDnAEBGnf74TKl0BMVxssTOK4Z3SoM1szScT16rWDi5PIiU
 b9Ig==
X-Gm-Message-State: AOJu0YzFbrm0uNdInFj3XbTeiLbwBRtDG08yddZiCE/t29Fz/0b62GqR
 jT3zrcgDJdc+sbJKw6mOGBAK9E7Gw/jhmA8wk8eBoDznlejfpb30Ce13abv0arrM61OGffXWQUX
 4yHeaAAzCs/0N9Xo=
X-Received: by 2002:a05:600c:143:b0:405:377f:5417 with SMTP id
 w3-20020a05600c014300b00405377f5417mr5185805wmm.39.1696526144849; 
 Thu, 05 Oct 2023 10:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmtJYi7IPkUx6f7Tc6m/C54dzJWoVaJ8A3b7ov1Xe9sd5sL1FrsIyznKLCQ2YnJHJF93+vdA==
X-Received: by 2002:a05:600c:143:b0:405:377f:5417 with SMTP id
 w3-20020a05600c014300b00405377f5417mr5185785wmm.39.1696526144483; 
 Thu, 05 Oct 2023 10:15:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:cded:de7:6702:3b9d:235c])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b00405c33a9a12sm2080570wmi.0.2023.10.05.10.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 10:15:43 -0700 (PDT)
Date: Thu, 5 Oct 2023 13:15:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <20231005131352-mutt-send-email-mst@kernel.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005170852.GB1342722@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, MISSING_SUBJECT=1.799, SPF_HELO_NONE=0.001,
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

On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
> > There is no clearly defined purpose for the virtio status byte in
> > vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
> > feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
> > protocol extension, it is possible for SET_FEATURES to return errors
> > (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
> > 
> > As for implementations, SET_STATUS is not widely implemented.  dpdk does
> > implement it, but only uses it to signal feature negotiation failure.
> > While it does log reset requests (SET_STATUS 0) as such, it effectively
> > ignores them, in contrast to RESET_OWNER (which is deprecated, and today
> > means the same thing as RESET_DEVICE).
> > 
> > While qemu superficially has support for [GS]ET_STATUS, it does not
> > forward the guest-set status byte, but instead just makes it up
> > internally, and actually completely ignores what the back-end returns,
> > only using it as the template for a subsequent SET_STATUS to add single
> > bits to it.  Notably, after setting FEATURES_OK, it never reads it back
> > to see whether the flag is still set, which is the only way in which
> > dpdk uses the status byte.
> > 
> > As-is, no front-end or back-end can rely on the other side handling this
> > field in a useful manner, and it also provides no practical use over
> > other mechanisms the vhost-user protocol has, which are more clearly
> > defined.  Deprecate it.
> > 
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
The fact current backends never check errors does not mean they never
will. So no, not applying this.

-- 
MST


