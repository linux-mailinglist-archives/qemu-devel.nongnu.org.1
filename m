Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3F7CA08C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHzO-0004FK-3L; Mon, 16 Oct 2023 03:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHzJ-0004F4-Ig
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHzG-0005j9-Uu
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697441162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hBy/bgj49iIQxplJ6/jQ2+UQ61/uGGLB/25c45ClTQI=;
 b=RD0XaEIaH5NY0klwgLYtlN+UPtHN8wZRHmKgxf0CocFrJiIBskS8123VIZAOYt7NZzqrXk
 YN1nG6P/eVg7AbEHnfGc9qsqyerlB28lNCIjYvqmM7833x2lBNm6G8WogMWnAZ/K/7go8F
 6d1lDY0PHxMx3dlotrzDs94kqTWQVPA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-pkjhY9FEPy24GSn1BMVozA-1; Mon, 16 Oct 2023 03:25:55 -0400
X-MC-Unique: pkjhY9FEPy24GSn1BMVozA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5042bc93273so3678447e87.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697441153; x=1698045953;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBy/bgj49iIQxplJ6/jQ2+UQ61/uGGLB/25c45ClTQI=;
 b=gObcwyTBymWFTz6Sj0EipQUFoXU/29WIw1ToJqN1IAjwG9PgQAM32WPHJniHFv9iqZ
 Eytk3ddYKJdAhvbcQczrzrs6KkEHiH0VZATzpA3Bsz0vMhFaitKb3YGg3cl+o0oyGl56
 pOcTVd00vKNMkcLB6fFaDwSfmuKgqQkcTXg6St+LNgo48zH5kIL4XTjvHj95YaxQUMsl
 mZMwvTWzlIA0uXzjR0SuDWEBv4FigqdaEMnF6pL4uIo9FYIboJIzJ9mtaxAvmjjUBtI7
 d89WEBjla1kW9pKgXlv7DoPc3cweiLvVDbeKYIliIqt/+w5AI67ovmx8oxlL73lkEw49
 i1VA==
X-Gm-Message-State: AOJu0YwxJnOiJuTLLDLyBhQAlAS+mzGzVqxXi+AHVF4abL9P7LiOzx8B
 FbgV/bKmueJzHB6u4UFiuC7/06uussvljZG4Ku3cLGGOqm94LqmCQmm9PA8ozbtOz3yPao2Zyc6
 i5J0/JiyHjL69sPQ=
X-Received: by 2002:a05:6512:2022:b0:505:6c99:bd7c with SMTP id
 s2-20020a056512202200b005056c99bd7cmr23758930lfs.57.1697441153727; 
 Mon, 16 Oct 2023 00:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLeegASQi+NGGVByMYvmXy+bSo7Z3157Y0QGMsZ2p1URrEyYiBXVxUQxfuYtxIshhO6I5nTw==
X-Received: by 2002:a05:6512:2022:b0:505:6c99:bd7c with SMTP id
 s2-20020a056512202200b005056c99bd7cmr23758920lfs.57.1697441153430; 
 Mon, 16 Oct 2023 00:25:53 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 jb17-20020a05600c54f100b00401bbfb9b2bsm1075734wmb.0.2023.10.16.00.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:25:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/4] multifd: fix counters in multifd_send_thread
In-Reply-To: <20231011184358.97349-4-elena.ufimtseva@oracle.com> (Elena
 Ufimtseva's message of "Wed, 11 Oct 2023 11:43:57 -0700")
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
 <20231011184358.97349-4-elena.ufimtseva@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:25:52 +0200
Message-ID: <871qdv58qn.fsf@secure.mitica>
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> wrote:
> Previous commit cbec7eb76879d419e7dbf531ee2506ec0722e825
> "migration/multifd: Compute transferred bytes correctly"
> removed accounting for packet_len in non-rdma
> case, but the next_packet_size only accounts for pages, not for
> the header packet (normal_pages * PAGE_SIZE) that is being sent
> as iov[0]. The packet_len part should be added to account for
> the size of MultiFDPacket and the array of the offsets.
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


