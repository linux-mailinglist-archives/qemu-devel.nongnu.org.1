Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B981AA89D20
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 14:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4f0q-0007Uk-K2; Tue, 15 Apr 2025 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4f0g-0007Ti-E2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4f0d-00047g-JL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744718601;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faioURmLKweUcXo45An6w9LMsgAuq8gdmON2D6iaSE8=;
 b=T5TC1yLPKczoypkClL+kPRwdIcvrK7WP9gPWK8vr6uGdm2E5eLfvAOjycTH+g1TwrH/Qiq
 HeZgxjFHpT/Y+8qLpgRNz6MKXrBDzeWyFW3AJ1XfXiHxvTixzDFlopvKQXeGGEnMOj7oA3
 GUtrhzWsNPBlXfvjQdTQtgqutVlPNl4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-e6S3Gu-kOK-whyUNeyV2gQ-1; Tue,
 15 Apr 2025 08:03:18 -0400
X-MC-Unique: e6S3Gu-kOK-whyUNeyV2gQ-1
X-Mimecast-MFC-AGG-ID: e6S3Gu-kOK-whyUNeyV2gQ_1744718597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5259D195608D; Tue, 15 Apr 2025 12:03:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8EBC180175D; Tue, 15 Apr 2025 12:03:13 +0000 (UTC)
Date: Tue, 15 Apr 2025 13:03:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <Z_5K_c3W2PSlEJJ8@redhat.com>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <Z_4zL4y0UbmLJTsP@redhat.com>
 <CAE8KmOz-yGRXo2RiPpnhtcg2K+j38sK6C1eGHvpQf0L_Hfe3vw@mail.gmail.com>
 <Z_489fbXq-1Ihnhu@redhat.com>
 <CAE8KmOxMK_k6hUNm6XgLoRJOC5NO6V2owkqtK5KsmEeyc_kp2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8KmOxMK_k6hUNm6XgLoRJOC5NO6V2owkqtK5KsmEeyc_kp2w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Apr 15, 2025 at 05:27:02PM +0530, Prasad Pandit wrote:
> On Tue, 15 Apr 2025 at 16:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Because that's what the QEMU API specification declares
> >  * Not all implementations will support this facility, so may report
> >  * an error. To avoid errors, the caller may check for the feature
> >  * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
> >
> > and what the QEMU API impl defines
> >
> >       if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
> >           error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
> >           return -1;
> >       }
> 
> * ie. _FEATURE_SEEKABLE should be set iff the underlying
> channel/stream supports seek (random access) functionality, right?
> That is quite connected with the lseek(2) OR ->io_seek() and such
> support, no?

The current semantics of QIO_CHANNEL_FEATURE_SEEKABLE is that it indicates
whether qio_channel_{preadv/pwritev} are usable or not.

For plain files that may also indicate that lseek is possible. For the
block driver based channel that doesn't map as there's no concept of
current file marker for that.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


