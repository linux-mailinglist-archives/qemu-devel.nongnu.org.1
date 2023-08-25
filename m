Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AFC788DAF
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZaOD-0003kC-PP; Fri, 25 Aug 2023 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaOB-0003jt-EH
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaO9-0001RG-4S
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692983663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4gTtFFVXg7NtMjSgmlfwke1nl3dXmaYTVlbjevpnjs=;
 b=XlykaiB3nFqtGEMKyqHjNYjRwa7Kshb3A4iJz66F8c8FCueH/E294K7983qMtRawpV0oIt
 wU8GQ/VdMC6f1j+KSiZK8Z5EE/vI9tY3APbH/N4F1fmRGQZtN33sCTx4a24U3F00Z/k+5f
 caW1ZsTagpwliX6wJcVS1X+wc9X7+ik=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-zcU9CfMNNR6C_LEySj_EPQ-1; Fri, 25 Aug 2023 13:14:22 -0400
X-MC-Unique: zcU9CfMNNR6C_LEySj_EPQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-64726969c8bso3605216d6.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 10:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692983661; x=1693588461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4gTtFFVXg7NtMjSgmlfwke1nl3dXmaYTVlbjevpnjs=;
 b=YIKyZY/LtVRfuE3JSZPh+CUAwbKN6WUTsRYrkzcMWj48Mkk+uK9Geoe7TuEAO37suK
 ulSw4c3tMBhspP18TLJKjKscsKhYz4PbF6ZSZTrwnomiHIAgRgRyEBIKrCrm7mMHDjVR
 7Qs8PWXKWENO+jNKkwtqQPQTlaFep6Zf/Lnzeua40WY2rFmQQ9vqZpG7sTqo0dlIjw3A
 qH+3PInvLjeyzW+cj8t+d6rbYVLGgCoXDbdT6o/NKyu3KuX7P4jFu7+FTbSQoqCnph4o
 hhT3mu8rWDtyoJ83ROS5hVHisFhCzqXhwTFXSuRNm4qTjG7LBbNSW53zAsGV1HBZE+qb
 G47w==
X-Gm-Message-State: AOJu0YzclRGsf29gb4X75Ox1HKo6bV7r9d1AQoAdDshLZZQUnlsMigtS
 ysjp8q95NwVq+uiPMELPktdTg7Zh7aJ45iQlYk6UM1Fw0yXcS2NNQH4Jq+4U9ybmD3wZq4JsNfR
 BhRFGr1R9w+lWWnVlD+b5wL1jVZhGfC2+nBzX57q6OqlEt3913xgBvPCk4mSULNNKJ+PLtVu3
X-Received: by 2002:a05:6214:e62:b0:641:8d4a:1a83 with SMTP id
 jz2-20020a0562140e6200b006418d4a1a83mr21663317qvb.3.1692983661579; 
 Fri, 25 Aug 2023 10:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8cO5llibRWBXfVdLfH6Bcwx7mcGfAc2O12mcA4duq9syy4tOXWydthCP0VUQcXxE/HkhVRA==
X-Received: by 2002:a05:6214:e62:b0:641:8d4a:1a83 with SMTP id
 jz2-20020a0562140e6200b006418d4a1a83mr21663302qvb.3.1692983661289; 
 Fri, 25 Aug 2023 10:14:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z11-20020a0cf24b000000b0064f732aa463sm662825qvl.105.2023.08.25.10.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:14:21 -0700 (PDT)
Date: Fri, 25 Aug 2023 13:14:19 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH for-8.2 3/4] migration/qapi: Replace
 @MigrateSetParameters with @MigrationParameters
Message-ID: <ZOjha2I+8sKODzWS@x1n>
References: <20230814221947.353093-1-peterx@redhat.com>
 <20230814221947.353093-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814221947.353093-4-peterx@redhat.com>
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

On Mon, Aug 14, 2023 at 06:19:46PM -0400, Peter Xu wrote:
> Here to deduplicate the two objects, logically it'll be safe only if we use
> "StrOrNull" to replace "str" type, not vice versa.  However we may face
> difficulty using StrOrNull as part of MigrationState.parameters [1] when
> replacing existing @MigrationParameters to use StrOrNull.  With the fact
> that nobody seems to be using "null" for tls-* fields (see the long
> standing qemu crash bug on tls-authz when "null" was passed in), let's use
> "str" to represent both objects.
> 
> This greatly deduplicates the code not only in qapi/migration.json, but
> also in the generic migration code on handling transitions between
> StrOrNull <-> str types.
> 
> [1] https://lore.kernel.org/all/ZNKfoqM0V6pcvrz%2F@x1n/

Markus helped me to work out this problem.  I'll send a new version soon to
switch to StrOrNull for all tls* fields.

Thanks,

-- 
Peter Xu


