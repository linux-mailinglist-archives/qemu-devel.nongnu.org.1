Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B487B7DBD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzeH-0001GS-AR; Wed, 04 Oct 2023 07:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnzdt-0001DG-05
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnzdj-0007xO-U9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696417322;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4ewSvn6BOuCUDgNAOwuQUKDs4EZ/EdbxcdnCJ+7aXjQ=;
 b=ij7PHG0tW4dEXobth4oCrKQueaAtuMDIwRIGo1wlT04MmMMGDfcPH6BiTJ6fQbFlN49I2s
 MsUHvSXiNqPE2alnZB4onQPkjZngtTVWcCLHocxLIEn7UKEfz4oiQh+3Z42wn3RSAnoE7v
 l99NhJJ5KedYv1TF/32YTmTgNAXPZtw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Wwbif5XcOQ-RGSSJTpN8hg-1; Wed, 04 Oct 2023 07:01:58 -0400
X-MC-Unique: Wwbif5XcOQ-RGSSJTpN8hg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3231d7d4ac4so1502465f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696417317; x=1697022117;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ewSvn6BOuCUDgNAOwuQUKDs4EZ/EdbxcdnCJ+7aXjQ=;
 b=rmGC5kf2G/LS+PwhVb75GgLsWnUf+HRUsaa5TaLuJLzbZfQXj0i9qJUm2HeUUtftYA
 T6SF1gnTMStwnxn7hRZ6E58kWIY/NOAN66ParJ6YF+hmBIFEVKfqkeznQEPxq76Tr3u9
 Kd+UFJT7Or2PqreQJeBEn+yEl7WKqXeI3PitYAdT9S/RlzcVWcqdPtA3GdRB8HF/9Noh
 v0ZHA8FJydE4bZ+3Dp6PiUtH2Q1uQO9utKg+xW698cU09AYD6eMePfgSLg6VbzUFCPNj
 qB557f3M21E/ygAU6TMBMwZFNYn3gZNEJrIcP5FvW2feC1JmclVFmWdCCOX62h50AGuT
 DkbQ==
X-Gm-Message-State: AOJu0YxSP8Hvdfr5G8HpTtOIAIDNuuAGbnBnIh+qJuj31SzMo6VwKsGf
 uwgQITZwXLjLCOOkLYQGs0nRDPEzIT0fBTWIbyJoDpSvnoLm523uYGGrBK1rrw3/QNvF2YfaYWO
 WE6t1C7WtDEc2j5w=
X-Received: by 2002:adf:f44e:0:b0:324:84cd:5e67 with SMTP id
 f14-20020adff44e000000b0032484cd5e67mr1601050wrp.6.1696417317039; 
 Wed, 04 Oct 2023 04:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuuux4KyDxop7Y24Xu949cx28JurWohxl0JC2WqgysLlDtEkVTOfOBDHsEClOGZVfRFXy9BA==
X-Received: by 2002:adf:f44e:0:b0:324:84cd:5e67 with SMTP id
 f14-20020adff44e000000b0032484cd5e67mr1600998wrp.6.1696417316007; 
 Wed, 04 Oct 2023 04:01:56 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t8-20020adff048000000b0031431fb40fasm3733577wro.89.2023.10.04.04.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 04:01:55 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH V5 1/2] migration: file URI
In-Reply-To: <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 8 Sep 2023 07:22:10 -0700")
References: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
 <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 13:01:54 +0200
Message-ID: <87fs2q4pnh.fsf@secure.mitica>
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
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be
> used as an alternative to 'exec:cat > file' in minimized containers that
> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
> It can be used in HMP commands, and as a qemu command-line parameter.
>
> For best performance, guest ram should be shared and x-ignore-shared
> should be true, so guest pages are not written to the file, in which case
> the guest may remain running.  If ram is not so configured, then the user
> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
> the same page, causing it to be appended to the file multiple times,
> and the file may grow unboundedly.  That issue is being addressed in the
> "fixed-ram" patch series.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


