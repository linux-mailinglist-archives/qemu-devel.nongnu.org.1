Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E367CA219
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJE2-0006X2-47; Mon, 16 Oct 2023 04:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsJE0-0006WY-Fb
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsJDy-0000j0-MH
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697445917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BJmDSj55oo6K0mTK9x3yvQ0pmoGjkIVHyy662A0yeLo=;
 b=Fa1huOgxvi+MDa/umow0aZBZSbgzU4+P55a13OTQRwgCrWfrUuYYqq3PjUK1qEfK4ORzEF
 evt5+yGAt+J4X5LtWgUhcKKlfWpW2YqDwoc4g7x6u7yDBH9qOqm7DGoxqxIe/IlmOdPq73
 35gfMRCS0xYvf93x7KyHeMfqad75K1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-NcnFvpwcO1WKLxYneyDbjA-1; Mon, 16 Oct 2023 04:45:16 -0400
X-MC-Unique: NcnFvpwcO1WKLxYneyDbjA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d58708cd5so2520985f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697445915; x=1698050715;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJmDSj55oo6K0mTK9x3yvQ0pmoGjkIVHyy662A0yeLo=;
 b=URxrnI66P/O8gFKG1K8D1vUk8S4xNZC7PU+8DaLs+N8ktk0CtxB6ssScu0bwSGguOg
 6jM4lZhtT6I6KHXGnRUjh+pGbLIuFi9isztVPx2K/b87fcqItTTNYR1qT6OlsNeNITuS
 RIF1xHsR34Gzlq+0a83T0PV/Yh7C+MYJy3r9/j5mkrZy5bgFZ6JVeVc89HH9bs9cnmfS
 eZwU0nP541tjS0OdeuH30t8z9FGkEFwRwttS2IJIqZkagYtgBhCJ88XL8Q/Fxh4SPvuJ
 QyF524vs5DVb84AcMPuv8WeZSyM4L0F1ArZEth7kVUGmy2Il+OFByDE1wZ+ALgIRyArw
 iWIA==
X-Gm-Message-State: AOJu0Yzbyoep2gwpNAQ1eWLFdou5ewNaUuwqedtwoJeO31jvdHyGA3tn
 wL34GZz5r2rgOEln8q9t48onb0pESZbpwjgU+DpOkNETa9dqlqciSFKEwpEoBvr17eJbYMu4DGo
 jH9tIEg2d7ccg2Kc=
X-Received: by 2002:a5d:66d0:0:b0:32d:bae7:6ab4 with SMTP id
 k16-20020a5d66d0000000b0032dbae76ab4mr713244wrw.64.1697445915228; 
 Mon, 16 Oct 2023 01:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRsLMpZyzKq+cPc7CXNygFkvoPKIeTATehiFPor1MtiTEFrEIDEZP183CfQaRZHxMPVRF1EA==
X-Received: by 2002:a5d:66d0:0:b0:32d:bae7:6ab4 with SMTP id
 k16-20020a5d66d0000000b0032dbae76ab4mr713232wrw.64.1697445914905; 
 Mon, 16 Oct 2023 01:45:14 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e6-20020adffc46000000b0032da75af3easm4761945wrs.80.2023.10.16.01.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 01:45:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration/multifd: Remove direct "socket" references
In-Reply-To: <20231012134343.23757-2-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 10:43:41 -0300")
References: <20231012134343.23757-1-farosas@suse.de>
 <20231012134343.23757-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 10:45:13 +0200
Message-ID: <87cyxf3qhy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> We're about to enable support for other transports in multifd, so
> remove direct references to sockets.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


