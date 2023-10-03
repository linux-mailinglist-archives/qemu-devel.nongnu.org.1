Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46707B7169
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:00:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkap-0007VO-I4; Tue, 03 Oct 2023 14:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnkaO-00072I-Ql
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnkaN-0007Q8-Dt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696359454;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Xhi7AbYGcWEpC75VRFc86Xrdx6JuLGsUZ6gNqp6U1wA=;
 b=Dy6UdAvVIOpl653VVQ5RUZLFQ5K2UxAs2eTO4ZGoV2D7MQOD3W1UL97eRHgCkXV9qhgzEq
 vn3Gxm1Kv0Gul7AkM3CF0QECLhvr3MAGlmdFr9Zc+Y3ULNnXEvQZLlBzficB5jamG6TJ9a
 gWo4VM9V94fJIW+0eiyqr1z20Pdxpyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-rdQPW5AkOnGmIhwa0VGR_w-1; Tue, 03 Oct 2023 14:57:33 -0400
X-MC-Unique: rdQPW5AkOnGmIhwa0VGR_w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405535740d2so9751375e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696359452; x=1696964252;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xhi7AbYGcWEpC75VRFc86Xrdx6JuLGsUZ6gNqp6U1wA=;
 b=CDqekcEapP9e3lqff3uh1J3tAuBReGQojxSdVJPb3MJ7mqofuSg2BQycnC5vEkIKNB
 6Vqy5YxVEUzheXBnQEFBTvdfPqmvxAIrT/dFwmSkG+JfFsEDphNf7I3G+6IJLK8Qrj8O
 N+H42vd13/k5X4KZyOifGVFPBN0xrr0jeW44SI2A4+XyzsRkw9z8UKmwYJ0bu7bdx47G
 s2nk2COIbZHhAfNI5xDWNffBz58YzZGaUYP9WnAydvaUgR4Ua3+fKMxsjdiwxBcdmXp4
 GBsDPLDasnnbDb/69Cw74TQskGh4MqjVl8IuiZV1X00E3S0CsjLjIMzSl62bv6xG1Q13
 iC1A==
X-Gm-Message-State: AOJu0YzPCSIyoDVfQaBHH9pb6F0ZJkOKPicuKG2lBSbJalsLUPwpxwBM
 rUNF4hHOnxPQ/XqE4XVm0GRh4U+Pg0I97ugDuLboF4+nQ/JEdUlyjCJJLz2jPF7BwycUt1phfTe
 8Iuu2PGmHKN103H4=
X-Received: by 2002:a05:600c:4686:b0:405:95ae:4a94 with SMTP id
 p6-20020a05600c468600b0040595ae4a94mr322779wmo.5.1696359452276; 
 Tue, 03 Oct 2023 11:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSk8bT1H/ebMQYJKEnd9rPslb8sHMopVrvt8lp9r2mBA4guaxiXZFTIj2eQNYP/0rftT9CAg==
X-Received: by 2002:a05:600c:4686:b0:405:95ae:4a94 with SMTP id
 p6-20020a05600c468600b0040595ae4a94mr322768wmo.5.1696359451894; 
 Tue, 03 Oct 2023 11:57:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fee53feab5sm1894552wma.10.2023.10.03.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:57:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: peterx@redhat.com,  leobras@redhat.com,  qemu-devel@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/2] migration/rdma: zore out head.repeat to make the
 error more clear
In-Reply-To: <20230926100103.201564-2-lizhijian@fujitsu.com> (Li Zhijian's
 message of "Tue, 26 Sep 2023 18:01:03 +0800")
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
 <20230926100103.201564-2-lizhijian@fujitsu.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 20:57:30 +0200
Message-ID: <87a5sz5yat.fsf@secure.mitica>
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

Li Zhijian <lizhijian@fujitsu.com> wrote:
> Previously, we got a confusion error that complains
> the RDMAControlHeader.repeat:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>
> Actually, it's caused by an unexpected RDMAControlHeader.type.
> After this patch, error will become:
> qemu-system-x86_64: Unknown control message QEMU FILE
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


