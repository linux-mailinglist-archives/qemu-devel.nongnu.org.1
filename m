Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A474B870
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 23:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsbE-0001VS-Oi; Fri, 07 Jul 2023 17:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHsbD-0001VJ-5A
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHsbB-0002ot-Eo
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688763759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3Jc45xmpMqcSOt/nqg1ISdiGWt36PuFqYiF8nPFNVY=;
 b=PilEubwE+/PJJwGD/9ZQF3r427dcxpGP+i46rVtCtEY1qTS7xgF1z7rnV8XSuf1BvI/guT
 hwDDSLsQ99Wk1ebhTWVOj41Zl9tpgJUEETzFuuaUQoaix2pIl+8ZVG5WuULrNF2/22oh+B
 KMW7OByZ1AmH6Fj8MKA0bONd6OHIvpY=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-13NKGTLaNSmZ71bRxdaG4g-1; Fri, 07 Jul 2023 17:02:37 -0400
X-MC-Unique: 13NKGTLaNSmZ71bRxdaG4g-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7944afceb23so44506241.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 14:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688763757; x=1691355757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3Jc45xmpMqcSOt/nqg1ISdiGWt36PuFqYiF8nPFNVY=;
 b=CaiWOOwHJ/AWfQxb7JhvuGor6hBXdeXnxl3kPM8uANpmkQoZ2oNSFmwDhGdVSzZXDi
 gIzgl/TKvy1hv8CXGII1odCnMK8v6wS8trMnJ+O1osgPl3b0Y+V2VpgIpyQmaskpIFTo
 faaXPaRWg9kgyExyRJaNdwOr6X47AoXFbdM3GZg46lYawLD5tzzL9jlWaxnrfAl5BMKn
 T4oE3e89prL3b70uwHdunGRaCB/MbKXgdY5XoMl3bb5YkHyWG+/cSbr16a0KYg4acuk/
 B5WIyeOs5U+3ijZpl73MvH9KfbJbASP91N9Py8zx5Ips8ar1Y1hUoUiFHZTQa9FJ1OFX
 vvyA==
X-Gm-Message-State: ABy/qLZKP8Phcf3z3c1BdWO9/I4YWcyz6HZpGNWZVW8s8UtTctnHzpxE
 pCTT9Cfd+Fkt0CTuAT7jWaANNJ2kGU86B8qXhhq5V3m92dwymb4n5XkcUw4jTkehsuo2o0j0VIE
 3zRpdvlMMrKFPqqo=
X-Received: by 2002:a05:6102:1590:b0:443:94f2:234f with SMTP id
 g16-20020a056102159000b0044394f2234fmr3724007vsv.1.1688763757413; 
 Fri, 07 Jul 2023 14:02:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0NdANY1513LYbj6ABG2CMtZ4J7Ko+KgHUVqhq5fBJLwHHaL91C27nWYcDK25kaMHSkQ6X+w==
X-Received: by 2002:a05:6102:1590:b0:443:94f2:234f with SMTP id
 g16-20020a056102159000b0044394f2234fmr3723986vsv.1.1688763757095; 
 Fri, 07 Jul 2023 14:02:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t18-20020a0ce2d2000000b00636291d04adsm2467488qvl.47.2023.07.07.14.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 14:02:36 -0700 (PDT)
Date: Fri, 7 Jul 2023 17:02:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH V4] migration: simplify blockers
Message-ID: <ZKh9WYhYwaGIy359@x1n>
References: <1688761248-32741-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1688761248-32741-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jul 07, 2023 at 01:20:48PM -0700, Steve Sistare wrote:
> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
> reason.  This allows migration to own the Error object, so that if
> an error occurs, migration code can free the Error and clear the client
> handle, simplifying client code.
> 
> This is also a pre-requisite for future patches that will add a mode
> argument to migration requests to support live update, and will maintain
> a list of blockers for each mode.  A blocker may apply to a single mode
> or to multiple modes, and passing Error** will allow one Error object to
> be registered for multiple modes.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

What's the change comparing to v3?

If no major change, feel free to keep my R-b.

Thanks,

-- 
Peter Xu


