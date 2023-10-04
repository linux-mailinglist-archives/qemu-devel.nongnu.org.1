Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C97B8331
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Ss-00066B-OT; Wed, 04 Oct 2023 11:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3Sq-00065D-Qw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3Sp-00019Y-9N
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696432021;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+HzMFTpNkYmnKySjAvhxtK5GrMBtpfHKZtJKcQ0iRRs=;
 b=T5/70IjN0kM5/pGUlZ0gAlDY165flhLeUBnnDc9PLReDlYEeEWd9f384LELHnDihHGVVOk
 +9qV6HPJJbZHo6lhlL4Ty0UrgNg4sa4BuEwHr6u/RR2gX6kpn1B8UBFsNGfbCcMoLL/xwE
 sJgiN786vfYA/45qCeOts5Qo05rjSAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-k0M7X3ywNXiR8Dtp5rouhA-1; Wed, 04 Oct 2023 11:06:58 -0400
X-MC-Unique: k0M7X3ywNXiR8Dtp5rouhA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-323306960e3so1567608f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696432016; x=1697036816;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HzMFTpNkYmnKySjAvhxtK5GrMBtpfHKZtJKcQ0iRRs=;
 b=NFt3VoyBU1A76Ax2LjwoGpGrVrQTggy09/FTq5/smgrBnOsjhOcWfkd1ggn8+nwUkF
 0EbpxYhUS7FMjkZRZHmpsoV+/xAPmI2RZF8ST/56XzjKR05c1eu7IW9WpJAYvHAoc4+9
 mTqHs39odkndydnPIqxICCDFzDPKCTQWj+hp9ojgQF788DeRRL+Yf1QTAVF+HMItP5Sj
 Bs4MIxYBBU+1qdfqiyXeS7JTyVOga6oE+nowK93kUaQTtFYQhS29h/qM5RmBOuqR4sTC
 sr6pEhrJ9X2CXtVkYebhK/T4lP8RYacI+HdKiNACGQS6noiJZ378nVBKXqETwfmKGETJ
 Z++g==
X-Gm-Message-State: AOJu0YyUvRaGIiI586XAnsCtH+NrmATEzujwkyS6gukMsQGAOOAS7igQ
 duX8iQTd4pj41UgU7I2+HiPxlMt2vUZkQ1JQ4PFwOgr0Row3s30eIShMEV/YD35aV1+Gt1Umlwm
 yPk/HERaeYeMSObc=
X-Received: by 2002:adf:f386:0:b0:323:2b6a:59c5 with SMTP id
 m6-20020adff386000000b003232b6a59c5mr2165692wro.67.1696432016687; 
 Wed, 04 Oct 2023 08:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGObHBiPy38Wb7cZy6JoGFT6v5EuIRXjPSM48J8loWBOpo0V7bc/9UPjo+pVYis/g2tWd0l8g==
X-Received: by 2002:adf:f386:0:b0:323:2b6a:59c5 with SMTP id
 m6-20020adff386000000b003232b6a59c5mr2165674wro.67.1696432016377; 
 Wed, 04 Oct 2023 08:06:56 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m4-20020adffa04000000b0031980783d78sm4227675wrr.54.2023.10.04.08.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:06:55 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 17/53] migration/rdma: Ditch useless numeric error
 codes in error messages
In-Reply-To: <20230928132019.2544702-18-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:43 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-18-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:06:54 +0200
Message-ID: <87h6n6xw8h.fsf@secure.mitica>
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
> Several error messages include numeric error codes returned by failed
> functions:
>
> * ibv_poll_cq() returns an unspecified negative value.  Useless.
>
> * rdma_accept and rdma_get_cm_event() return -1.  Useless.
>
> * qemu_rdma_poll() returns either -1 or an unspecified negative
>   value.  Useless.
>
> * qemu_rdma_block_for_wrid(), qemu_rdma_write_flush(),
>   qemu_rdma_exchange_send(), qemu_rdma_exchange_recv(),
>   qemu_rdma_write() return a negative value that may or may not be an
>   errno value.  While reporting human-readable errno
>   information (which a number is not) can be useful, reporting an
>   error code that may or may not be an errno value is useless.
>
> Drop these error codes from the error messages.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As I didn't catch the previous on (waiting the discussion to end), I had
to fix one error_report() by hand, nothing complicated.


