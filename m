Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522D7BB42A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoh6O-0001WT-JE; Fri, 06 Oct 2023 05:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoh6E-0001Vr-7G
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoh6C-0005fS-3R
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696584378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBFXap4oO8Xic6+ikNIzNQiGxIiLKsOzn6cC1HhPmSU=;
 b=eprWLPSm5CVqX6Ic4eAPxskHdece1YDE0+tk2H6rNzGk+tE7xlVRegOYMrWUzriBJHb9Jf
 OljTYX+Le8IC8w1Kytq4A3b2TnukKBy+EDSFMNULvcrW2NjHWhDlyiwkJBi5W5Onp1l+oQ
 aDMsdV40KwCH5eRcLNJ5Il/LYFHnVPE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-V6d6zXLHPbeoIYuofu_7gA-1; Fri, 06 Oct 2023 05:26:17 -0400
X-MC-Unique: V6d6zXLHPbeoIYuofu_7gA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3231fceb811so1370598f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696584376; x=1697189176;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBFXap4oO8Xic6+ikNIzNQiGxIiLKsOzn6cC1HhPmSU=;
 b=txDlG9XOad2maOE5j7TDNBjA2QM6zAMjG55cDxjcfGu8FIhQ7Lj7/akHkAs5RhR0qf
 euvB6AwCRftd5d1r973lkVPjV662B3OwgDogPm1swENhNEXfEUDXwj8BIHVhmmaE22K2
 GsLuhisoYAVvKEJb9pujAkZEfI+QocW+LLQNkB0c3qVbbVMzqm0xYWG6vzHcz2ttMCt+
 3JiLvZsRnzeW5/KEJC/jMUJOpwYCsnWXxeyyNTr74qfP/vUku2mtSHOnrcEFJomsR6SO
 97sYr/bExR+P+OTsjYXfY7Tk7t3W/3rqpaYU1Sd/MjCtQ/MSbyRfM1Q0+jS/zRmuDe53
 80hg==
X-Gm-Message-State: AOJu0YyQu9GOKgcSALD0oXwuF5WqU8J7TzQMXE8aDXUBqF4x8KtQzLmM
 K5qyAf4muebgJoXDjz7kM/DNpWIJ6EQDY0rMVhZ1aideiziBBOz+weI5rJ1EJJ0YqrM3U8PdXkj
 odtFJPfwauIiyiEo=
X-Received: by 2002:adf:b34a:0:b0:329:6c6a:c733 with SMTP id
 k10-20020adfb34a000000b003296c6ac733mr503376wrd.58.1696584376273; 
 Fri, 06 Oct 2023 02:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHguFx7EhezEHbqKh62Q1f2kf7Ms3kDVgZ7WVYaDjfP720Bgp8RAJXKKF8lCXbtNu1uQeCPNg==
X-Received: by 2002:adf:b34a:0:b0:329:6c6a:c733 with SMTP id
 k10-20020adfb34a000000b003296c6ac733mr503359wrd.58.1696584375843; 
 Fri, 06 Oct 2023 02:26:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:170:ca0a:84b4:d350:99ea:3666])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a5d6b0b000000b00324853fc8adsm1194874wrw.104.2023.10.06.02.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 02:26:14 -0700 (PDT)
Date: Fri, 6 Oct 2023 05:26:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Yajun Wu <yajunw@nvidia.com>
Subject: Re: [Virtio-fs] (no subject)
Message-ID: <20231006051802-mutt-send-email-mst@kernel.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
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

On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
> On 06.10.23 10:45, Michael S. Tsirkin wrote:
> > On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
> > > On 05.10.23 19:15, Michael S. Tsirkin wrote:
> > > > On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
> > > > > On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
> > > > > > There is no clearly defined purpose for the virtio status byte in
> > > > > > vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
> > > > > > feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
> > > > > > protocol extension, it is possible for SET_FEATURES to return errors
> > > > > > (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
> > > > > > 
> > > > > > As for implementations, SET_STATUS is not widely implemented.  dpdk does
> > > > > > implement it, but only uses it to signal feature negotiation failure.
> > > > > > While it does log reset requests (SET_STATUS 0) as such, it effectively
> > > > > > ignores them, in contrast to RESET_OWNER (which is deprecated, and today
> > > > > > means the same thing as RESET_DEVICE).
> > > > > > 
> > > > > > While qemu superficially has support for [GS]ET_STATUS, it does not
> > > > > > forward the guest-set status byte, but instead just makes it up
> > > > > > internally, and actually completely ignores what the back-end returns,
> > > > > > only using it as the template for a subsequent SET_STATUS to add single
> > > > > > bits to it.  Notably, after setting FEATURES_OK, it never reads it back
> > > > > > to see whether the flag is still set, which is the only way in which
> > > > > > dpdk uses the status byte.
> > > > > > 
> > > > > > As-is, no front-end or back-end can rely on the other side handling this
> > > > > > field in a useful manner, and it also provides no practical use over
> > > > > > other mechanisms the vhost-user protocol has, which are more clearly
> > > > > > defined.  Deprecate it.
> > > > > > 
> > > > > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > > > ---
> > > > > >    docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
> > > > > >    1 file changed, 21 insertions(+), 7 deletions(-)
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
> > > > The fact current backends never check errors does not mean they never
> > > > will. So no, not applying this.
> > > Can this not be done with REPLY_ACK?  I.e., with the following message
> > > order:
> > > 
> > > 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is
> > > present
> > > 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
> > > 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
> > > 4. SET_FEATURES with need_reply
> > > 
> > > If not, the problem is that qemu has sent SET_STATUS 0 for a while when the
> > > vCPUs are stopped, which generally seems to request a device reset.  If we
> > > don’t state at least that SET_STATUS 0 is to be ignored, back-ends that will
> > > implement SET_STATUS later may break with at least these qemu versions.  But
> > > documenting that a particular use of the status byte is to be ignored would
> > > be really strange.
> > > 
> > > Hanna
> > Hmm I guess. Though just following virtio spec seems cleaner to me...
> > vhost-user reconfigures the state fully on start.
> 
> Not the internal device state, though.  virtiofsd has internal state, and
> other devices like vhost-gpu back-ends would probably, too.
> 
> Stefan has recently sent a series
> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.html) to
> put the reset (RESET_DEVICE) into virtio_reset() (when we really need a
> reset).
> 
> I really don’t like our current approach with the status byte. Following the
> virtio specification to me would mean that the guest directly controls this
> byte, which it does not.  qemu makes up values as it deems appropriate, and
> this includes sending a SET_STATUS 0 when the guest is just paused, i.e.
> when the guest really doesn’t want a device reset.
> 
> That means that qemu does not treat this as a virtio device field (because
> that would mean exposing it to the guest driver), but instead treats it as
> part of the vhost(-user) protocol.  It doesn’t feel right to me that we use
> a virtio-defined feature for communication on the vhost level, i.e. between
> front-end and back-end, and not between guest driver and device.  I think
> all vhost-level protocol features should be fully defined in the vhost-user
> specification, which REPLY_ACK is.

Hmm that makes sense. Maybe we should have done what stefan's patch
is doing.

Do look at the original commit that introduced it to understand why
it was added.

> Now, we could hand full control of the status byte to the guest, and that
> would make me content.  But I feel like that doesn’t really work, because
> qemu needs to intercept the status byte anyway (it needs to know when there
> is a reset, probably wants to know when the device is configured, etc.), so
> I don’t think having the status byte in vhost-user really gains us much when
> qemu could translate status byte changes to/from other vhost-user commands.
> 
> Hanna

well it intercepts it but I think it could pass it on unchanged.


> > I guess symmetry was the
> > point. So I don't see why SET_STATUS 0 has to be ignored.
> > 
> > 
> > SET_STATUS was introduced by:
> > 
> > commit 923b8921d210763359e96246a58658ac0db6c645
> > Author: Yajun Wu <yajunw@nvidia.com>
> > Date:   Mon Oct 17 14:44:52 2022 +0800
> > 
> >      vhost-user: Support vhost_dev_start
> > 
> > CC the author.
> > 


