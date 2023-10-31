Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C17DCDB7
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:22:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxogi-0004EC-Th; Tue, 31 Oct 2023 09:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxogg-0004DB-Nz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxogf-0001b9-AD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698758500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dS48wXQh+L87Gyw4OjE32B3EEntBWQ40KlyGRSVzsc0=;
 b=DLuu/qBUFXvSmTM5YBq1MPoc4OeIz4uWlIdv4C0AsKrKCqc4d78tyFX8o0dKjg5JC72q5b
 EAphoKC4UvuWgc6ZnYQ9pyN4Chaz6RsIWa3LYUVCu9/nGfCQcZJUzwNytHh6Y0wVgWhiAI
 txyxbG2/eC12yPhZFJ8etVv0Lkvl5rk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-iSgqTb98PdWcwe2f73Myng-1; Tue, 31 Oct 2023 09:21:29 -0400
X-MC-Unique: iSgqTb98PdWcwe2f73Myng-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4094e5664a3so6431495e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698758487; x=1699363287;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dS48wXQh+L87Gyw4OjE32B3EEntBWQ40KlyGRSVzsc0=;
 b=GEjBWq9Sx+CLipttk2qextDP5JPZqgr8DlSHWvh3wC6Tu6nPV3SdhnFdJP45JDSqtu
 1ETz4MSzlWPdNoU5a/TkHB/tDvvmNbn8WkODfqGIKoFTDMYttXNhyQ5nasyiGaG77/cV
 ia23zV6BfqgaW0D4RX7ADdMacrF7gT6Vssjp1VzW4Iev8SnJ2oxE7HnneGl2EuAtAh5I
 uzByQkg6uTgF4VLM5ywINtaeOfBkziQtfBGGHoz8lMq4K0w32Vo5F0lTOS+4Szud+7GS
 uxC54WyKCzFM2cYlUYm23uSgvQUIqB+/YJXksoJ+wBN7Cn7QcfPILgPGcg+otmiESPR4
 +0PA==
X-Gm-Message-State: AOJu0YzijQRzl07wvMoSQiprC2IR9vZ3ZBe8OHK4jLMpkNxi28TUOQ32
 TOxQbJAe3aHh6OyDBbCnyWI8Fxc0IdKhaZ0KISOctMUEtLdbzzwXbam0RxJbNb6l7HggjReIXG6
 ZlrupD9CubiMyIS8=
X-Received: by 2002:a05:600c:3146:b0:3f6:58ad:ed85 with SMTP id
 h6-20020a05600c314600b003f658aded85mr10440715wmo.10.1698758487696; 
 Tue, 31 Oct 2023 06:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTwWW3dP0r3Q+vrzvYVGUxoo37sGDzBALN/45NoRwOxMlJU1+GpUZZ/4qzqW9qMA3j5kFpRA==
X-Received: by 2002:a05:600c:3146:b0:3f6:58ad:ed85 with SMTP id
 h6-20020a05600c314600b003f658aded85mr10440694wmo.10.1698758487277; 
 Tue, 31 Oct 2023 06:21:27 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004068de50c64sm1703063wmm.46.2023.10.31.06.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:21:26 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V2 5/6] cpr: reboot mode
In-Reply-To: <1698263069-406971-6-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Wed, 25 Oct 2023 12:44:28 -0700")
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-6-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 14:21:25 +0100
Message-ID: <87ttq76i7e.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Steve Sistare <steven.sistare@oracle.com> wrote:
> Add the cpr-reboot migration mode.  Usage:
>
> $ qemu-system-$arch -monitor stdio ...
> QEMU 8.1.50 monitor - type 'help' for more information
> (qemu) migrate_set_capability x-ignore-shared on
> (qemu) migrate_set_parameter mode cpr-reboot
> (qemu) migrate -d file:vm.state
> (qemu) info status
> VM status: paused (postmigrate)
> (qemu) quit
>
> $ qemu-system-$arch -monitor stdio -incoming defer ...
> QEMU 8.1.50 monitor - type 'help' for more information
> (qemu) migrate_set_capability x-ignore-shared on
> (qemu) migrate_set_parameter mode cpr-reboot
> (qemu) migrate_incoming file:vm.state
> (qemu) info status
> VM status: running
>
> In this mode, the migrate command saves state to a file, allowing one
> to quit qemu, reboot to an updated kernel, and restart an updated version
> of qemu.  The caller must specify a migration URI that writes to and reads
> from a file.  Unlike normal mode, the use of certain local storage options
> does not block the migration, but the caller must not modify guest block
> devices between the quit and restart.  To avoid saving guest RAM to the
> file, the memory backend must be shared, and the @x-ignore-shared migration
> capability must be set.  Guest RAM must be non-volatile across reboot, such
> as by backing it with a dax device, but this is not enforced.  The restarted
> qemu arguments must match those used to initially start qemu, plus the
> -incoming option.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


