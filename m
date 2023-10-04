Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9AE7B8336
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3WG-00083Z-Dl; Wed, 04 Oct 2023 11:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3W6-00081T-Oi
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3Vq-0001gt-1m
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696432203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mFPWWUk7DVhQZsiHCDlUZmk8o98y9JEVFqA4r3wmx5o=;
 b=OPhqVsfVikeQ9xEermHavr7ltbWIDX5qbJlKANXNeSVk1JQM9Djz2roHwF1KG4MRhSbBEW
 oJXNbdNQfMyTS9z+3K4WfYyH+9SzwQTF6PqPJrRNvoJJigEaxH+DXgULOZ2iAqYf0icDoD
 dAUCMYi4jcxVXjKvDTY9X/sSsjy/7vw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-HuR6lnd_NBKT4K1QkwY67g-1; Wed, 04 Oct 2023 11:10:01 -0400
X-MC-Unique: HuR6lnd_NBKT4K1QkwY67g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40554735995so16567365e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696432200; x=1697037000;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFPWWUk7DVhQZsiHCDlUZmk8o98y9JEVFqA4r3wmx5o=;
 b=QKINN7wuz/2+DerBNXXGkQVpt41tHbfIVvJVZf+k/NdcErE3uQ2fGDqCkKQRDk4qYX
 IR7RLSuYYMxjnMdwAzUodkJtXH8dVP0tQ7+OqwmxwPwdNZudJDQ/YWMFf9Km7LapJ5+F
 R0GJRdeDHhpQM/t2YUnBvAnFMifqdS9udw2xoJ3JD3yG6VOTbyrtdfCcWQvd1JUGuL0a
 Oxw6dEOHSgF1m8s+nkUq2JxNijGYzSc26lhsjKk9CHWiO7YwdVThGLow8roaeAEmPOF5
 POXxz8BSDKywlgBvK7apsATGaEnFqvpwi7XLukc3qa6CIRL85eeyZou2mufFzNU1w0nQ
 eFNA==
X-Gm-Message-State: AOJu0Yw2ukrikYPHfUkTGJmlQ4VXUIDQ1uV1K62dYGpix35U0sqTXDOB
 r+wdJhFWb7Xfm1hdGl62GBOujakRP2Q9II4V+FLuSCvkhNYI/VULlXHvecspG4edO6Vp9/I7/7o
 WbX9bmRNIKBIH2sY=
X-Received: by 2002:a05:600c:c9:b0:406:3fda:962c with SMTP id
 u9-20020a05600c00c900b004063fda962cmr2395971wmm.31.1696432200585; 
 Wed, 04 Oct 2023 08:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFecFXNNL2xgTcX3bwwOLjV8GJsULgk4X5kSASTbWy24L6DeDhL9qf6X8QIBCaUURWSygMMmQ==
X-Received: by 2002:a05:600c:c9:b0:406:3fda:962c with SMTP id
 u9-20020a05600c00c900b004063fda962cmr2395954wmm.31.1696432200262; 
 Wed, 04 Oct 2023 08:10:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z9-20020a7bc7c9000000b004060f0a0fd5sm1745935wmk.13.2023.10.04.08.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:09:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 18/53] migration/rdma: Fix io_writev(), io_readv()
 methods to obey contract
In-Reply-To: <20230928132019.2544702-19-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:44 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-19-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:09:58 +0200
Message-ID: <87cyxuxw3d.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> QIOChannelClass methods qio_channel_rdma_readv() and
> qio_channel_rdma_writev() violate their method contract when
> rdma->error_state is non-zero:
>
> 1. They return whatever is in rdma->error_state then.  Only -1 will be
>    fine.  -2 will be misinterpreted as "would block".  Anything less
>    than -2 isn't defined in the contract.  A positive value would be
>    misinterpreted as success, but I believe that's not actually
>    possible.
>
> 2. They neglect to set an error then.  If something up the call stack
>    dereferences the error when failure is returned, it will crash.  If
>    it ignores the return value and checks the error instead, it will
>    miss the error.
>
> Crap like this happens when return statements hide in macros,
> especially when their uses are far away from the definition.
>
> I elected not to investigate how callers are impacted.
>
> Expand the two bad macro uses, so we can set an error and return -1.
> The next commit will then get rid of the macro altogether.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


