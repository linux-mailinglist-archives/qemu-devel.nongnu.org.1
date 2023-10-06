Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0A7BB371
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogTD-0000qY-Sa; Fri, 06 Oct 2023 04:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qogT8-0000qH-AH
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qogT4-00046X-HO
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696581953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pIdEmtdJJg6CuyB7ctMoU308T+uHaEgo6fkgL2wv6U=;
 b=D9N7UVIW3LY99lVATAA2kaUO6yCITEUP5yOZbB3cP+nNOXGQyXIlKW16camCDzxtpNFXdC
 XV3/SqjlIMRXLY7barGhGy+So1Y5FRD8I1uejadULd9SpnXpih5X8nuNDpaiH2CP1GxMew
 M5p8DXcmzHb8/vd2H5N1mVwn0lWzzm0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-HEUy7WqLNkeoCN-8-q0TRw-1; Fri, 06 Oct 2023 04:45:52 -0400
X-MC-Unique: HEUy7WqLNkeoCN-8-q0TRw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso158131066b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696581951; x=1697186751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8pIdEmtdJJg6CuyB7ctMoU308T+uHaEgo6fkgL2wv6U=;
 b=WoPhYj3yWhx7bAAPH/yBhcYhM0lFujxTHezQeZ6brEm96cKhNXwXvULATSJDpI3g6L
 dLHfqE++Z1ZtxcwFvgqfuXats4feSJkA2gMZIWo7XcgUZ+/cS4hr5BK/N2fG9o/mDYpf
 WLBtvwW64qoG9+xlHyL8obxih1lRqDCMC7UztszC6kY6rdmGdBBWfbjrbROpqc47gf62
 TLTbfNemmYZN9iczXp70akrHB3TCOcZ3iIaHPIcb9VhvjiXbxGK8QnEpjCT4T4hM5css
 0WYZv8X3cAv7dgwSqIlSBaw5h6pLYN6c8WGxa8wN/NGS8CKRs8cOd+FsC6QkLZ0/eRep
 StCg==
X-Gm-Message-State: AOJu0YywufthwOi0Lzuu2jF6nk0VzSXv3KhLkTviq7xSNJ+bAhhHkeP6
 V9agqYfAjyE846Q8VkyZAVHu62jXYmKOxbVUE1Nfz+cLSYYBic6q2GUVt8z1Vm3uDPmXZ629KI2
 wwsnV80UX2OtCTOw=
X-Received: by 2002:a17:906:23e2:b0:9ad:7d5c:3d4b with SMTP id
 j2-20020a17090623e200b009ad7d5c3d4bmr6203265ejg.35.1696581950940; 
 Fri, 06 Oct 2023 01:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFJjGO5QvgGqqqTVwJzUpVCpmy+5k1Tp5x9H0MveMFw3qmlZ9ThqmvlQleEF0loQoS+M9aAA==
X-Received: by 2002:a17:906:23e2:b0:9ad:7d5c:3d4b with SMTP id
 j2-20020a17090623e200b009ad7d5c3d4bmr6203252ejg.35.1696581950512; 
 Fri, 06 Oct 2023 01:45:50 -0700 (PDT)
Received: from redhat.com ([109.253.187.99]) by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4649000000b0031fb91f23e9sm1138327wrs.43.2023.10.06.01.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 01:45:49 -0700 (PDT)
Date: Fri, 6 Oct 2023 04:45:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Yajun Wu <yajunw@nvidia.com>
Subject: Re: [Virtio-fs] (no subject)
Message-ID: <20231006043518-mutt-send-email-mst@kernel.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
> On 05.10.23 19:15, Michael S. Tsirkin wrote:
> > On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
> > > On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
> > > > There is no clearly defined purpose for the virtio status byte in
> > > > vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
> > > > feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
> > > > protocol extension, it is possible for SET_FEATURES to return errors
> > > > (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
> > > > 
> > > > As for implementations, SET_STATUS is not widely implemented.  dpdk does
> > > > implement it, but only uses it to signal feature negotiation failure.
> > > > While it does log reset requests (SET_STATUS 0) as such, it effectively
> > > > ignores them, in contrast to RESET_OWNER (which is deprecated, and today
> > > > means the same thing as RESET_DEVICE).
> > > > 
> > > > While qemu superficially has support for [GS]ET_STATUS, it does not
> > > > forward the guest-set status byte, but instead just makes it up
> > > > internally, and actually completely ignores what the back-end returns,
> > > > only using it as the template for a subsequent SET_STATUS to add single
> > > > bits to it.  Notably, after setting FEATURES_OK, it never reads it back
> > > > to see whether the flag is still set, which is the only way in which
> > > > dpdk uses the status byte.
> > > > 
> > > > As-is, no front-end or back-end can rely on the other side handling this
> > > > field in a useful manner, and it also provides no practical use over
> > > > other mechanisms the vhost-user protocol has, which are more clearly
> > > > defined.  Deprecate it.
> > > > 
> > > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > ---
> > > >   docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
> > > >   1 file changed, 21 insertions(+), 7 deletions(-)
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
> > The fact current backends never check errors does not mean they never
> > will. So no, not applying this.
> 
> Can this not be done with REPLY_ACK?  I.e., with the following message
> order:
> 
> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is
> present
> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
> 4. SET_FEATURES with need_reply
> 
> If not, the problem is that qemu has sent SET_STATUS 0 for a while when the
> vCPUs are stopped, which generally seems to request a device reset.  If we
> don’t state at least that SET_STATUS 0 is to be ignored, back-ends that will
> implement SET_STATUS later may break with at least these qemu versions.  But
> documenting that a particular use of the status byte is to be ignored would
> be really strange.
> 
> Hanna

Hmm I guess. Though just following virtio spec seems cleaner to me...
vhost-user reconfigures the state fully on start. I guess symmetry was the
point. So I don't see why SET_STATUS 0 has to be ignored.


SET_STATUS was introduced by:

commit 923b8921d210763359e96246a58658ac0db6c645
Author: Yajun Wu <yajunw@nvidia.com>
Date:   Mon Oct 17 14:44:52 2022 +0800

    vhost-user: Support vhost_dev_start

CC the author.

-- 
MST


