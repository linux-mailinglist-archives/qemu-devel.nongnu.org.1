Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608567B8338
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3WP-00085B-AY; Wed, 04 Oct 2023 11:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3WO-00084x-2W
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3WM-0001w0-Na
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696432242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kaKHAD80E66htPSR2IJpZiSwxj6yLC9JkvZiwTIvNEE=;
 b=Enn5IN7neRK/KB1/hJIGuHGUduejojysXG7xEFJQOZaHDDc/+gmVf9MkZBNWgjH+exP8QK
 I8w5PPIimC7Xk6ESSPIRtgHdhRbVqkMDZ1oI0YUiqHJVt3H4JcgdIUnu4hC8lT87H3mmya
 9+56aWakPxBE3TGuELI5woF1uHuP9vo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-851XxfEEOLOCf1l3Wq6qww-1; Wed, 04 Oct 2023 11:10:30 -0400
X-MC-Unique: 851XxfEEOLOCf1l3Wq6qww-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso15456075e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696432229; x=1697037029;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaKHAD80E66htPSR2IJpZiSwxj6yLC9JkvZiwTIvNEE=;
 b=RkjlR57x0Wk8LD6SKd7qBck0FUEW8i/mqnWN+BkTWi40fSpf/k/bUyterCbOBr4Swn
 VXxTVf8yVQtC5TKBLvAVOGLOekkoTr/Ty7Ym78qY6yFwh6H8jjKykaMF6qC7Ek4DM1Yr
 eYrs3B+BglJXdkOU2IgErO5CzCrK7BZbfZ3I2ilBStbfI9AEc6BU8fJvtYAzYdu4KThK
 XAYKFBjJ9hvvenypgnhIgS3Xv+3YT1AxxKKCoiFdCR+VdTI9jHkRKkGhGxsjwlOraEVm
 SZl1HvUL20XhUqlc447R2RHcm4iMx/7vB9LhCJwS/KtiWzc3YjodWZp5msOllD9RCrZ3
 CZyw==
X-Gm-Message-State: AOJu0YzVx3OoVVL34VmrMpYYxb9YgsZ+05XfaaWwvmeb9HK9kJb9xaik
 Abta3AtoHEDLrpqWbtTXEstFiv+edfn1qsIzhBKOqrvtA093YuMtnhxHOWBTwyFHwEJSMceL5kc
 98DFIRI63LsuMXBM=
X-Received: by 2002:a7b:ca57:0:b0:405:34e4:14cf with SMTP id
 m23-20020a7bca57000000b0040534e414cfmr2775923wml.4.1696432229218; 
 Wed, 04 Oct 2023 08:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/7hSy7LBxK5eRGwYt/SVSrVlJIK8D00fiHgp65zsPhHEPGazhIvxMeJtt5O5wT3q71J0H1A==
X-Received: by 2002:a7b:ca57:0:b0:405:34e4:14cf with SMTP id
 m23-20020a7bca57000000b0040534e414cfmr2775896wml.4.1696432228849; 
 Wed, 04 Oct 2023 08:10:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b003fee567235bsm1772497wmk.1.2023.10.04.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:10:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 19/53] migration/rdma: Replace dangerous macro
 CHECK_ERROR_STATE()
In-Reply-To: <20230928132019.2544702-20-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:45 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-20-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:10:27 +0200
Message-ID: <878r8ixw2k.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> Hiding return statements in macros is a bad idea.  Use a function
> instead, and open code the return part.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I hated this macro, thanks.


