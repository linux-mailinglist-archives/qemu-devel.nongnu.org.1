Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 411BD7701F0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:38:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuzo-0000e6-65; Fri, 04 Aug 2023 09:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRuzl-0000dx-RP
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRuzk-0001dK-FE
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691156251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSgpi7RrRqDB/SFoZ2ufJdRQgepYI98/DgrT5M+z3Xo=;
 b=LZqZ/3la0GUlK3+qaEX4hHkJRQ+uRLAVRQ9I+oO8O6KyyuiFv1seRh2Bosq0B0k+/6s4ue
 CzbDLZqdh038uyfP3DITzfOmqH0iGTNGdTI8BzPRz5I3YuCilQSOTUES3Qp3WS7aiKodT7
 cA4Ir61t0igHe9o5g90OZjY9kbtjxYg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-esFjfUvSNuOwy1-3WexvGA-1; Fri, 04 Aug 2023 09:37:30 -0400
X-MC-Unique: esFjfUvSNuOwy1-3WexvGA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76cb292df12so56661785a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691156249; x=1691761049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSgpi7RrRqDB/SFoZ2ufJdRQgepYI98/DgrT5M+z3Xo=;
 b=E/9BcD3U/c1N0MYzL7luKCZo2JLteRjHZAPAnnCFXijfPl4a3REFH3dDlBTT8FHJgL
 HOZTB9HF+bPT2QMO79rzDvncYh78USfMdUaKrCD1vH14CqRpIjUXeinEy/RHIQcmbj0Q
 1zjIOMjqKaMtR+WuTCXYWvLYVtDJofD/sV9jxrneut2g3NMqLt34h8ptsI3IcZTUWqsI
 Y4lmbSjW3a50+hiDqqlBt1ipWqXCpXx1PIjDyovUaihAkattiN8YH7Fqf0g2XxmXFfeo
 GAHVFvtwrKKM0Jkks0zIsCzdFLAoInLGWvXLEWyAQEJssefKjlNvve+6gptVtxVUi0oy
 YvhQ==
X-Gm-Message-State: ABy/qLaZAG9235LSvFmD15Z6U/kmFUTitbf9LkO6ESG1HtKKFp6ieMUQ
 4ih23V90A6iGpOJ/iBrcKStK6Qrd9pDCqfurBppPszAhU5iAFD4SIQmnnTAmhn7AaDs5Op3wMaB
 aTDWSMo8/+tLsFwY=
X-Received: by 2002:a05:620a:1914:b0:76c:bf60:4707 with SMTP id
 bj20-20020a05620a191400b0076cbf604707mr13333973qkb.0.1691156249638; 
 Fri, 04 Aug 2023 06:37:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlELce8kjgNwQYvqr4kaw9k94/aol+pV2wOJ/cbUBgjb4/Fp89l8bJ2PTmJ3a7K9U1jLSWEGaQ==
X-Received: by 2002:a05:620a:1914:b0:76c:bf60:4707 with SMTP id
 bj20-20020a05620a191400b0076cbf604707mr13333953qkb.0.1691156249280; 
 Fri, 04 Aug 2023 06:37:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x15-20020ae9f80f000000b0076639dfca8dsm644211qkh.80.2023.08.04.06.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 06:37:28 -0700 (PDT)
Date: Fri, 4 Aug 2023 09:37:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: quintela@redhat.com, isaku.yamahata@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: refactor migration_completion
Message-ID: <ZMz/GEdnh1opN/o3@x1n>
References: <20230804093053.5037-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804093053.5037-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 04, 2023 at 05:30:53PM +0800, Wei Wang wrote:
> Current migration_completion function is a bit long. Refactor the long
> implementation into different subfunctions:
> - migration_completion_precopy: completion code related to precopy
> - migration_completion_postcopy: completion code related to postcopy
> - close_return_path_on_source: rp thread related cleanup on migration
> completion. It is named to match with open_return_path_on_source.
> 
> This improves readability and is easier for future updates (e.g. add new
> subfunctions when completion code related to new features are needed). No
> functional changes intended.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


