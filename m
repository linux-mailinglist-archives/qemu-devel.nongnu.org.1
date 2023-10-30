Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF947DBD87
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:11:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxUqK-00052m-Hs; Mon, 30 Oct 2023 12:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxUqA-00051F-4d
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxUq0-0006Bh-M3
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698682195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AiVANJVbdwM6U9ZGoA4WRmpJiKJIb+pEZiV6OwI9WzU=;
 b=QB/0tL3LW14J/4bZagKedKAKw1eqWMyeBWbK31oLtPu3l3Jht/BmqRAajsJVOUf5GQIA6a
 yfaUsI3Bl6xULVR93bxf9ghDQRch9oVL0BfJnQeDb5NaKfFTx+ea36DXpRPmUDv+3znIF4
 DdPWEooN07NzthfuqC2aAdplsQSmCRU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-qxMgRa6dMhGxgfHQ8-J8OA-1; Mon, 30 Oct 2023 12:09:53 -0400
X-MC-Unique: qxMgRa6dMhGxgfHQ8-J8OA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6716c2696c7so7822706d6.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698682193; x=1699286993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiVANJVbdwM6U9ZGoA4WRmpJiKJIb+pEZiV6OwI9WzU=;
 b=jvVGO98iYM3MKXUBcpXKIr0DmGeoZsPrgrNrDe/Ebzpfu2FbduyzDlQrVMW87Hv/Cb
 AGcBpO+TZvSMhyl8UV5uL5XkqL542KBnTiwZTyYgEcjcRmmhsNAZuLfmhGGVndc0cFpG
 krqty8Lb11ERSTGccC9OO4SWLXFJl5NIyKxSoH58EWWu5a9QhjcQx6SueNGhXEmLy9nR
 86gTIZxGqU3B+vt8YxMa/b6vYlA8Cp2QAjahmtGUEsq4229gOC6n2UyZ1j1kcims7eLw
 /HXrVThkXAzok0WrE1VR11nMZy5ksPON8h1NjjH6oJVSP4Bqv68ooQJ7QH5dX8cpJSS2
 B0Xw==
X-Gm-Message-State: AOJu0YzkHNkWbuSGc7b1nv139bCoYcfNbPrBrcTjTbNjjeFk1YZo9ZRz
 q5fAx81enj0ztFdsM1zMOaPnYqQOj7jJt7VIbcuJpTs3TT6euEXaSsOry9UFBcKCzDBouupCEy2
 bHo6aldeNtwTM4uc=
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id
 kr24-20020a0562142b9800b0065d048625c6mr10853982qvb.3.1698682192722; 
 Mon, 30 Oct 2023 09:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+eQoKIEK2oKXQOh0IyVUP9aNkUq+LzK5nzAlyXGeibTyLG3DFwBTnsunuVxhZziYgQHcXLQ==
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id
 kr24-20020a0562142b9800b0065d048625c6mr10853967qvb.3.1698682192434; 
 Mon, 30 Oct 2023 09:09:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ph4-20020a0562144a4400b0066da90f0c19sm3515940qvb.24.2023.10.30.09.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:09:52 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:09:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Message-ID: <ZT/VKagmVpzDuUrd@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
 <ZTqb/XDnwhkTUL3s@x1n> <ZTqtieZo/VaSscp5@x1n>
 <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
 <ZTrHAbyDxLsDl007@x1n>
 <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
 <ZTvMEqYYVS4KjL0F@x1n>
 <e6be9230-2f63-4c48-9db4-5eff2c4399eb@oracle.com>
 <ZT/IM4gz6s6PfKg8@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZT/IM4gz6s6PfKg8@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On Mon, Oct 30, 2023 at 11:13:55AM -0400, Peter Xu wrote:
> > Perhaps it is easy to wrap the checkpoint tracepoint in its own function to
> > allow extension of something else e.g. add the timestamp (or any other data into
> > the checkpoints) or do something in a particular checkpoint of the migration.
> > The timing function from qemu would give qemu own idea of time (directly
> > correlable with the downtime metric that applications consume) which would be
> > more consistent? though I am at too minds on this whether to rely on tracing
> > stamps or align with what's provided to applications.
> 
> Yes it should be more consistent.  Let me add them into the checkpoints.

I just noticed dst qemu doesn't have downtime_start to offset..  Only
offset the src downtime checkpoints will make it less consistent.  I'll
leave this one for later.  Posting a new version soon.

-- 
Peter Xu


