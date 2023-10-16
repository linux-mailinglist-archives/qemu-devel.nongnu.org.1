Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E407CA25E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJHD-000179-59; Mon, 16 Oct 2023 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsJH5-00009e-8j
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsJH2-0001GN-Uj
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697446107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zMFszbY4PwhKMdu8ztp+RCKn1sl3tOStvgMAbFaLYho=;
 b=SKjSOhpkHwtIIEwpuCEy1uHf1Q8SFCsxAjAD4jf5Pywc2qBZ7bJK7V704J68o1FOatM5U3
 /TLb4Y7/jyTyq6QnzX13gW0vDoThfsLPgmZZfkCMPMn6ho1SSPYqtvbAOyo7uPUMsL9+cA
 yOBOGTyAObecOTnVNuFvBmRKHnxBPS8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-t-mGAkXkNm6uAZ4ThTeHsQ-1; Mon, 16 Oct 2023 04:48:25 -0400
X-MC-Unique: t-mGAkXkNm6uAZ4ThTeHsQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so179113f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446104; x=1698050904;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMFszbY4PwhKMdu8ztp+RCKn1sl3tOStvgMAbFaLYho=;
 b=KO/nonWLr45BetyR5OFkkFWjHNj3tAiWA28RAkXIyTPFAiK7iluwC4BNrf0Ury544Y
 XbuHPuJ3+kPs4c82Eo/FzS0Q+wReDMVtJu2uw2DIqZiIehrOHpoVHDmJYGYsjMrvvnX+
 pZptmatz+i8eL6SZAKmNyhXqEBfH0uYcRzu1Eg0K9k2TgH+innWqPB57+KIsnzTkPY3H
 oMzVmO/BMOrCFDCq7HoIOqcYk5kw1ZRl4NvIE6SYVaOJDPg+AE4o4Alj8LZymJRPzPUB
 PPMd1cFJtIH9oPllVrFyYSALQ/tL5UE3dnfkVnD3gUNUU940COOlJeGXhmZESReR3IoM
 J35A==
X-Gm-Message-State: AOJu0YyACMxHTOZHUYk9bA24eINOBCo5y8RSoKrhHbLwTw8L7BnLWNXB
 l5yfSfXjFYaByxWLa9DB4dDA73w+ppV9cxiKt3RDYta+zVM9s+/ueZqtj+7Mx1LqI+qkuG66SXq
 HF79sFhhHE1tiB9o=
X-Received: by 2002:a5d:480b:0:b0:320:6d6:315b with SMTP id
 l11-20020a5d480b000000b0032006d6315bmr5528937wrq.29.1697446104556; 
 Mon, 16 Oct 2023 01:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXKh9/p7fkFL1kxVFbjGPQm6BnHTEh3Lz23JKR8SYcp0z95CjVgH3ZtQv2XXLShNBGtKioCw==
X-Received: by 2002:a5d:480b:0:b0:320:6d6:315b with SMTP id
 l11-20020a5d480b000000b0032006d6315bmr5528919wrq.29.1697446104206; 
 Mon, 16 Oct 2023 01:48:24 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 ce9-20020a5d5e09000000b0032d687fd9d0sm15108318wrb.19.2023.10.16.01.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 01:48:23 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration/multifd: Unify multifd_send_thread error
 paths
In-Reply-To: <20231012134343.23757-3-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 10:43:42 -0300")
References: <20231012134343.23757-1-farosas@suse.de>
 <20231012134343.23757-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 10:48:22 +0200
Message-ID: <878r833qcp.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> The preferred usage of the Error type is to always set both the return
> code and the error when a failure happens. As all code called from the
> send thread follows this pattern, we'll always have the return code
> and the error set at the same time.
>
> Aside from the convention, in this piece of code this must be the
> case, otherwise the if (ret != 0) would be exiting the thread without
> calling multifd_send_terminate_threads() which is incorrect.
>
> Unify both paths to make it clear that both are taken when there's an
> error.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued.


