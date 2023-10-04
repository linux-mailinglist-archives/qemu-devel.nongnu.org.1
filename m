Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC057B8308
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3KO-0005tj-5p; Wed, 04 Oct 2023 10:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3KL-0005tR-H5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3KC-0005Hh-G0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431487;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LBvZ99f2Kk98HYDxsB7TSo+meH/p/JRFpKpE1gJKiDM=;
 b=XRbS3LecB2elQBlTlhcF2s44AA7ylWzfuk4AgcBCvbqGrK5gLVOkdt92vhV6QZbay3QOop
 9u3U1uAXP+MGERaMTrpS42Zavsx7aMpYaurMMZYHPGzfL2ui8AQ4Nw8C9bunPpfQocR4Q8
 UTEzTODVG1YSDLaI9oFKfTxzh0NQdQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-XVOQ9S2nPE6ZtiG6e0RiWA-1; Wed, 04 Oct 2023 10:58:05 -0400
X-MC-Unique: XVOQ9S2nPE6ZtiG6e0RiWA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso15414235e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431482; x=1697036282;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBvZ99f2Kk98HYDxsB7TSo+meH/p/JRFpKpE1gJKiDM=;
 b=SSa9ZtTATc730qB0OYE2or8hp1YM190In5Zv1QoKUWvte3g7d5n4NPVpZAxJs/3+EK
 2xdequlEC4hVYiJUqSEq6/mcJ5B3jpXXkwPQ9Flox3Exr7qftbEGv0UnVX2tFSs6oAbX
 T4CTu2b0++cd4R8bx/PosoOt4kXWJ7qo2/pevKONxni+vLl97iXQ0KmCG/aTEGlrjSoR
 b/KffeOCUh8hl9nEnxjUwpyjwNPFAeOYPe7w/4N7IJrPBwgYJnoEyeHkallQ49BomXKh
 MOCj/gjQx9duc53iFDnrfnH1Xm5n3H7vcF5hR3GE4cmAgiCCwrQWJ+dDLIFQNgkIyOB6
 vekw==
X-Gm-Message-State: AOJu0YxbIl+XixFJP7As823c7SX2uJWW9lpJGfm8S6DXbZjX5nkmqPvt
 Mwgu1kai7hjU8QRTMWGnK/BE72zwglV0TwZW75HAPlXfmI5+8chIfXiccjaOTlFOTOyn24P/x5Q
 9Ieqjvpc0IHtY++75N9xCMub4Xg==
X-Received: by 2002:a05:600c:2154:b0:402:ff8d:609b with SMTP id
 v20-20020a05600c215400b00402ff8d609bmr2633249wml.33.1696431482687; 
 Wed, 04 Oct 2023 07:58:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOveBMUM2m+N4dNjptZBBeNsHVnP4apJeqRfotk2w6gZ+WbJW1SuGKXC+GCDN3io+hkBp+zQ==
X-Received: by 2002:a05:600c:2154:b0:402:ff8d:609b with SMTP id
 v20-20020a05600c215400b00402ff8d609bmr2633232wml.33.1696431482303; 
 Wed, 04 Oct 2023 07:58:02 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o13-20020a05600c378d00b004063cd8105csm1718914wmr.22.2023.10.04.07.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:58:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 11/53] migration/rdma: Eliminate error_propagate()
In-Reply-To: <20230928132019.2544702-12-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:37 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-12-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:58:01 +0200
Message-ID: <87y1gixwna.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> When all we do with an Error we receive into a local variable is
> propagating to somewhere else, we can just as well receive it there
> right away.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


