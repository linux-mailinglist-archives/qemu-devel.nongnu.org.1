Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1562D7CDDF2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt70E-0004x8-0c; Wed, 18 Oct 2023 09:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt708-0004ar-50
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt704-0000bT-Ia
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697637254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bU9UBK4ewHYFHySwXutje85i2S67F+Qc7/J4Nklpn6Q=;
 b=fx0WBQkzW6Z41RGzMHOfGa5j+ctdQEA3RuPvgR5DNR5eszlahiIYniHR0FUAUVwfuEjP/u
 JRwT93XdOPGc+3NxVh97q6trBfUkZ25Kro42dUd4Qo7bqeJcxERimRx1zoRAMyAsQWj9bz
 K+4J0xzHYhGSJ6ikeICbwf6XdYPB4TY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-pjSIEb9aMRWviCp_RQAlTA-1; Wed, 18 Oct 2023 09:54:13 -0400
X-MC-Unique: pjSIEb9aMRWviCp_RQAlTA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50d4a1a33so44322341fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637251; x=1698242051;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bU9UBK4ewHYFHySwXutje85i2S67F+Qc7/J4Nklpn6Q=;
 b=ItUBWYORPQ2FcPZ7M4SMNpALm6/8nWnkvEBZo61Ema/rYwoZzCyKg/I+fYPahnRxGE
 cWPyTiBAXgw5vNtp+xr8xNwSeTCsL44UjcacvXhSqibtega6n7ghLYWNKB9hjj6TGoAV
 W5kH3Dw8IK21MNvjJB6AdYftCLMPyhK1Ccg511m/fYGeOvk7/JpREDtRD1WDFTEGsFpe
 OdsGc9UnNUEH+UCAB9Ab91MXp0HtwY7/FxfWG8VjEiOexO0wHBEOh5tQoJzgvZJb3Cif
 QR10Yd6US98panSh5En2u2ncGo9gJIY2U07JpnjiWG6kvWDibpM+4zeC5O6hZKYzXna5
 1Fhw==
X-Gm-Message-State: AOJu0YwUJXhC52naBTGjoEdSyOxy7txLBri5A2b7RqcN46FPEdh6fuca
 Opvg9BHHfEaIkSCr0MkNR4TnubJ4BCRNIkYtae4C4yGRDUZz+XfIbg5k6hkVv+RfghO/7NNPjUk
 FiJqqB/gmogIp1Vz1/OtuMBWkfrwK
X-Received: by 2002:a2e:a782:0:b0:2c0:1c32:b4df with SMTP id
 c2-20020a2ea782000000b002c01c32b4dfmr6098906ljf.15.1697637251164; 
 Wed, 18 Oct 2023 06:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDu4RV3HEqqSAc65Yl6ukrxibkWfpY+PjPEGeZ9FvW6m3DkDN0/7ucjR4DToTnY4Xgh3qb/Q==
X-Received: by 2002:a2e:a782:0:b0:2c0:1c32:b4df with SMTP id
 c2-20020a2ea782000000b002c01c32b4dfmr6098884ljf.15.1697637250766; 
 Wed, 18 Oct 2023 06:54:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b004063ea92492sm1775305wmb.22.2023.10.18.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:54:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Fix parse_ramblock() on overwritten retvals
In-Reply-To: <20231017203855.298260-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Oct 2023 16:38:55 -0400")
References: <20231017203855.298260-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 15:54:09 +0200
Message-ID: <87mswg829q.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> It's possible that some errors can be overwritten with success retval later
> on, and then ignored.  Always capture all errors and report.
>
> Reported by Coverity 1522861, but actually I spot one more in the same
> function.
>
> Fixes: CID 1522861
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


