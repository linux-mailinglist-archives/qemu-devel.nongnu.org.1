Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B6829404
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:10:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSiU-000626-99; Wed, 10 Jan 2024 02:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNSiQ-00061e-Tb
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNSiL-0005Iz-60
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704870563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nWg07WVU79klhAV1Bwqq7BlSBYGZZSoGEgyQkupRI4=;
 b=CJhekhn4NjKYk9fOy1b+n3oyyVNFyF6xjP0O06G4R/UCGNelDleEWeixblAAlo1d7dRyay
 O2sAOvfQVlljogvZpfnZBn5wBdCecsstHGtnH/i4UpEsKKvADppJkE4xYl0XZZATDKg65c
 L8/W+2z+d8sZonb4EC1O1T5zqvKAIxY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-lU518TMmN0ix3EuuZq7DnA-1; Wed, 10 Jan 2024 02:09:16 -0500
X-MC-Unique: lU518TMmN0ix3EuuZq7DnA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso383904a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 23:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704870556; x=1705475356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nWg07WVU79klhAV1Bwqq7BlSBYGZZSoGEgyQkupRI4=;
 b=a1D3xuOC/s7VjN3ieWROgLS2dNyFXGTs5DZZpUoZ7y9hxpXoHxT65JgwYVrWCqAvhP
 uFfWJ5gbiWS+OsOxbw5h3h7jNJ1NNrhsY+1tG8OlGtEog0HOeStyOP+g6wuL3KJq60ch
 gB4mskiUlajfNluhu3RQ/ph5uMMWSAxeqc364jQM5fE2OuZJJr1sBv1Ca9Ppcuy2SsMe
 sN09sFNDHdt6kBGgQK/jtfU8OtU2uDgRVjCgOxSGG7CV2age8Ri6AP7mdMBtHpzgwWvh
 YUrfWEMsypo0Kf23qoPSu6hHfWZ4h+fXn0PXrO2x+fz3AoEqE/GMVMgYdOQZ6jGaMyUU
 Wa0Q==
X-Gm-Message-State: AOJu0YyS3zhTMvldpj29L9Dyct1bsPvKHaZ75DUZECPI+CwtwySsthh/
 /aN64oy9VDzkOatAVWK0RFzzrgkCT/IEdBPMAajHQ5brgkBQt42U72kTe/NTpSltY0/z/S92a9Z
 p5y8Z2iz3upKAc4z0amMtNEs=
X-Received: by 2002:a05:6a20:a0a6:b0:199:9236:cc00 with SMTP id
 r38-20020a056a20a0a600b001999236cc00mr937027pzj.4.1704870555947; 
 Tue, 09 Jan 2024 23:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiw9eRPtud2dMVBXX6+sddPHM91sbtVtNQXyZB0R7fGJMojzlgcnEblKlhC9EHvskWHWy5AA==
X-Received: by 2002:a05:6a20:a0a6:b0:199:9236:cc00 with SMTP id
 r38-20020a056a20a0a600b001999236cc00mr937011pzj.4.1704870555643; 
 Tue, 09 Jan 2024 23:09:15 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 12-20020a17090a030c00b0028658c6209dsm786708pje.2.2024.01.09.23.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:09:15 -0800 (PST)
Date: Wed, 10 Jan 2024 15:09:05 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V1 1/3] migration: check mode in notifiers
Message-ID: <ZZ5CkQOhau48sqjn@x1n>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1702491093-383782-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Dec 13, 2023 at 10:11:31AM -0800, Steve Sistare wrote:
> The existing notifiers should only apply to normal mode.
> 
> No functional change.

Instead of adding such check in every notifier, why not make CPR a separate
list of notifiers?  Just like the blocker lists.

Aside of this patch, I just started to look at this "notifier" code, I
really don't think we should pass in MigrationState* into the notifiers.
IIUC we only need the "state" as an enum.  Then with two separate
registers, the device code knows the migration mode.

What do you think?

-- 
Peter Xu


