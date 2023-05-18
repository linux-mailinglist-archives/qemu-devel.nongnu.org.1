Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D2708848
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 21:21:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjAr-0003rN-4n; Thu, 18 May 2023 15:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzjAd-0003qy-Ln
 for qemu-devel@nongnu.org; Thu, 18 May 2023 15:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzjAX-0005oR-7O
 for qemu-devel@nongnu.org; Thu, 18 May 2023 15:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684437606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXBk621dbLnubqa+DnTuWMrOqMuN1a28oztcSWBO+Dw=;
 b=FUVax225lyxrxTvsSSS1nXXAvzDq/9BolLPU69AIdK20DSkvPdgh3ewqUvW3N2d2NPcWRB
 3l2r87vjrUqkJVpqVvFBpGdl7JrtoJzabv9OhdVNRT+HqNGPCcOofm+p9/3g7rC0NOmt14
 OA7OsqKdaCI3nbuNa4IaEw2lZvX7Kdk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-hD3_t6hSPsSDfq2tPnJSLQ-1; Thu, 18 May 2023 15:20:05 -0400
X-MC-Unique: hD3_t6hSPsSDfq2tPnJSLQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f38280ec63so4576811cf.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 12:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684437605; x=1687029605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXBk621dbLnubqa+DnTuWMrOqMuN1a28oztcSWBO+Dw=;
 b=R/jjH7RbXUPh0mHfQwe4u+VrCXNySI7xng/IF2N1V+GUNy8jOxxO8rOcqgRV46IddL
 YMAv/cUWLUe8aJOo5n+5/wCwSs+iza1QaJQa44BdRmfZUdL2cXM1Eu2OCLO+uue2eTXZ
 Cmjww2tFmyiwuEjrbEaHvonUWwY8VIngkl/2FnUWFZQyhzC6cORob8KaO2VOp0tHjkZA
 DeOobCxq8JQQx8jC4Hz0TslTGUWzvVoSp59ov9MK5tEYLtaT21CTQ+8fX3YY32R1Qboi
 m+BAxH+sU6xZkT/O8wPmJ0GyuOkvRqEH+wM2N6WVo0jKNUpXwDPWANY7I0tCXT1RXWs8
 ayAw==
X-Gm-Message-State: AC+VfDxslWsrFFmI2/IxG6qx4jgaON2exzQ4/viHGMRIzx7vojD2PUGd
 6wGOhVemkZHcPnQtfp0uhlGnFeg9kz7UmGVSwFd8pk8vSP1jgILAN2l1wndPZ//p1YAFiM+ERsb
 +SWRWIhwYBSOUK6k=
X-Received: by 2002:a05:622a:1a9f:b0:3f5:1def:67fd with SMTP id
 s31-20020a05622a1a9f00b003f51def67fdmr12927913qtc.2.1684437604836; 
 Thu, 18 May 2023 12:20:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ742xTKVXZ3YJms+XiE6qaLAy6jcRXSyl/d/Lfqy0ftT4uZvKwhSkXGPb+i/jRKSyyuZJ7EAg==
X-Received: by 2002:a05:622a:1a9f:b0:3f5:1def:67fd with SMTP id
 s31-20020a05622a1a9f00b003f51def67fdmr12927886qtc.2.1684437604600; 
 Thu, 18 May 2023 12:20:04 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 bn5-20020a05622a1dc500b003f68223f7d7sm724343qtb.8.2023.05.18.12.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 12:20:03 -0700 (PDT)
Date: Thu, 18 May 2023 15:20:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: quintela@redhat.com, lei4.wang@intel.com, berrange@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGZ6Yqx2+dOp+Q73@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518160026.57414-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 12:00:26AM +0800, Wei Wang wrote:
> qemu_start_incoming_migration needs to check the number of multifd
> channels or postcopy ram channels to configure the backlog parameter (i.e.
> the maximum length to which the queue of pending connections for sockfd
> may grow) of listen(). So multifd and postcopy-preempt caps require the
> use of deferred incoming, that is, calling qemu_start_incoming_migration
> should be deferred via qmp or hmp commands after the cap of multifd and
> postcopy-preempt are configured.
> 
> Check if deferred incoming is used when enabling multifd or
> postcopy-preempt, and fail the check with error messages if not.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

IIUC this will unfortunately break things like:

  -global migration.x-postcopy-preempt=on

where the cap is actually applied before incoming starts even with !defer
so it should still work.

Can we just make socket_start_incoming_migration_internal() listen on a
static but larger value?

-- 
Peter Xu


