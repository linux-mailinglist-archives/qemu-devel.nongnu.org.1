Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7527D3B8A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxG6-0000WF-0G; Mon, 23 Oct 2023 11:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quxG4-0000W7-Kc
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quxG3-0006bR-AJ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698076461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Th+D9dRVPWitNJyOLas7iwMPriJ/8uuv1Dy6Xe+kADY=;
 b=fN2672FmvdSoRGN+6mWv2aQWHaFwBkGSWoWRg8xMAVEEFWcIUjCLfBOVYVvn1eVRFm8iR8
 G6QeWQwphOeJRmtGKkKnpw8INiSYCOmLBTo7xERKNF7JA1escE47IZYxFCP9L8SV3E+cng
 jI3AyYvOBr+83frT+WJJHGUiOBKl5Gw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-rLB5vq5iOK-9mU4-tPo3IQ-1; Mon, 23 Oct 2023 11:54:18 -0400
X-MC-Unique: rLB5vq5iOK-9mU4-tPo3IQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77898c3fbd3so37290585a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698076458; x=1698681258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Th+D9dRVPWitNJyOLas7iwMPriJ/8uuv1Dy6Xe+kADY=;
 b=mXJaYxAkVzr4lPRyU//aTveUfmbmj0p2cjDaIDiSCFNxkvm87dYi/vOIyP164N6xwu
 gSBvEXal/amVZdGJISRohkddg3h0OujKZoHOqyXgA3GD+8eCC5IZB+NDJ55LfPhLDTur
 np+PwRxGqWdBHMnmoGxb8oV0qoaXwxiDA1Mwo3fVjq8YCHfEtH0GuKkPzzcPkzlDrGOH
 AQ0MZOmJVnAAUlc9Nul2fDAS6YX7gXT2X4tol4OjEb/+WGzvg47hE2VlgU3F8W66QSfP
 qkT0nJ9nWwJDP3suL1rwRgFbF1NItJyVhMW+zM9X6EvjoJZgf/1+m0I4iEnzCZqJghWc
 Td+w==
X-Gm-Message-State: AOJu0Yz6sEAjHtV8hVMqc9UiGu5gXqee6s/cJVl9Y4K3fLnGMKD/gIIF
 AIbwNDZH80PZPAg8lTFzVV9P5VpmzPZPHL9Sl3xNfEPRZO8T52eVmb/rOtMtzV3i5FkGzGopHRn
 Uzr3HyJX6XKHx9QA=
X-Received: by 2002:a05:620a:2790:b0:775:7921:732e with SMTP id
 g16-20020a05620a279000b007757921732emr9163373qkp.3.1698076458387; 
 Mon, 23 Oct 2023 08:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo24VMkRCO71IVOtBV15Rql3m6hD/DW57X+6R9e+q5FSir4w2KO+CCPgUuzOIv7iQ4KXOkqA==
X-Received: by 2002:a05:620a:2790:b0:775:7921:732e with SMTP id
 g16-20020a05620a279000b007757921732emr9163361qkp.3.1698076458074; 
 Mon, 23 Oct 2023 08:54:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n17-20020a05620a223100b007770673e757sm2806180qkh.94.2023.10.23.08.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:54:17 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:54:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH RFC 4/7] migration: Drop MultiFDSendParams.quit and
 cleanup error paths
Message-ID: <ZTaXJwXExv60D7L0@x1n>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-5-peterx@redhat.com>
 <87jzrdz9gr.fsf@suse.de> <ZTaI8vJpGeOQSfZH@x1n>
 <875y2xz6zt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y2xz6zt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 12:35:50PM -0300, Fabiano Rosas wrote:
> I don't, just thought of being conservative since this is a multifd
> external API (of sorts).

No worry, let me just keep it there.  Thanks for the quick reviews!

-- 
Peter Xu


