Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4AC7CE622
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtB6U-0007PQ-Uy; Wed, 18 Oct 2023 14:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtB6R-0007K0-KI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtB6P-0001DB-UL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697653024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nWBFdU8JuumYqNYy4fm2s62fWCGDeX/lY1VPDupP5o0=;
 b=KTQSKK6pF8ssJt9RKP9FaqOsX4X4S0Y5AKFTw1odrsBwevuDs5RNfnnhJmnJLjOKhh44Py
 jJBl8f2YmXWFN9gwRCaZXFLytVv1pxzufl8IifTwwOD3PPveABygzv7B/JUB8CDb9vRj1u
 s9sRUW5/JrVFTzR2jDg3X+gL+371m7E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-tExo8cWYODaovmDyKh0L1w-1; Wed, 18 Oct 2023 14:16:52 -0400
X-MC-Unique: tExo8cWYODaovmDyKh0L1w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50d4a1a33so46541211fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653011; x=1698257811;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWBFdU8JuumYqNYy4fm2s62fWCGDeX/lY1VPDupP5o0=;
 b=v6n6dlepDMdulNfHZbFsJF9/7f7lJjK4ftWXVLPDpIOgCCGAJ1yjidyeBrcJ9QhGnH
 yO6logU9zkGeCkw3BtQ2Hx5PSw2uNJE75XTSPu/mcndPSG098WM9haHskC6NlCFQfHiK
 62gmHKki0zYPkjDXIqMoQUIPYwmhTYDKZQl/1qNrGTETEzMTe8uWBLxjv3G0I/gqIUyh
 /PRzuOhHNdkcD2DbZNlR4G2nQgHb+vhgitdJ++vfQVavP5pr1z3W8pIbGgV8gC0Xh/Kd
 MPQ3GhO8ExXWqkAvIBrUbVHLsmMXC19bDwTnD3q0r1rWuaZwXSCmycRFWSK8KTJygndc
 N+KA==
X-Gm-Message-State: AOJu0Yyd2MOUqUjHteTe0Tki3TS2XxaMgUfjlU774EknoOYGaUrpABmu
 JAwjc5YUSG+XCT4Vd+KuNMBxaDp+gxGAYViYE67+i7yud7GYMnFBLW7x4w17oltlVOJMz4lLn/g
 kCYrvaMyUqSdJx5c=
X-Received: by 2002:a05:651c:510:b0:2c5:13e8:d54e with SMTP id
 o16-20020a05651c051000b002c513e8d54emr5219851ljp.38.1697653010908; 
 Wed, 18 Oct 2023 11:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0kNZfo48npoYfLafo53G5T8QsDjbpQZBesUjTHENTydY8zWpquiLtXLAkTRfpfYJpJ65k1g==
X-Received: by 2002:a05:651c:510:b0:2c5:13e8:d54e with SMTP id
 o16-20020a05651c051000b002c513e8d54emr5219833ljp.38.1697653010484; 
 Wed, 18 Oct 2023 11:16:50 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v18-20020a05600c15d200b004063d8b43e7sm2288449wmf.48.2023.10.18.11.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 11:16:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V3] migration: simplify notifiers
In-Reply-To: <1686148954-250144-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Wed, 7 Jun 2023 07:42:34 -0700")
References: <1686148954-250144-1-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 20:16:49 +0200
Message-ID: <871qdr94oe.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Steve Sistare <steven.sistare@oracle.com> wrote:
> Pass the callback function to add_migration_state_change_notifier so
> that migration can initialize the notifier on add and clear it on
> delete, which simplifies the call sites.  Shorten the function names
> so the extra arg can be added more legibly.  Hide the global notifier
> list in a new function migration_call_notifiers, and make it externally
> visible so future live update code can call it.
>
> No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


