Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E287DCDAA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:20:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoek-0002iw-MA; Tue, 31 Oct 2023 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoei-0002ib-9W
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoef-00011q-MI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698758377;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5EKHKjclMWDMPxHfjC9fIipt+lDcqtsUEvojH8394aM=;
 b=Ahac9USchsndIasjSre/JIX+mvYV4q++iBMVWYIelfbBZy4PmxR3NDH216+qN0w0VcwCU4
 Gc1q/JGCfy2Mv8zyQPR2lLmagOAE9FgSz4fh94dl9RwsJlsWG+8HeD+CVR+TmAjQaCio5e
 Qc3tNQcOEQ8TQMY/XQruhlNuUvQoVq4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-yPkO2omeNkC-M7mTY_4emQ-1; Tue, 31 Oct 2023 09:19:25 -0400
X-MC-Unique: yPkO2omeNkC-M7mTY_4emQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4094e5664a3so6416705e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698758364; x=1699363164;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EKHKjclMWDMPxHfjC9fIipt+lDcqtsUEvojH8394aM=;
 b=V38rm8myxxCMwEL2+5z1Pejfw29tS1djXzjQjWteAqdcfTAILgcEaaa0tlXNyW+k4Z
 NKAtvZh5AvfNjff+XhXKjV5NwZE4TS29j/70ZfIKUJjYlLtxlQFR55QWRziA03O0gfGQ
 MR3YRHDT7uuivsyVALM1eoeyq/OzfR7U552KC0lVVQowpCYGAnfYHP66PofuZqtyF+js
 MN1ayYSJfsu7nIhdSYrllyHNjzZm8XuFPVsgTCPWUy9eCGGCswdOTf5MmKwRRVCiwtt2
 DJ4y/l+WLgTh7Gjd5VqWcxW0+oTNvS5NumBTQVZ0GDENP37hBWbsy5JZtfWJnTtBlGrt
 rq2g==
X-Gm-Message-State: AOJu0YzzBk655B3VcCsT2QSAX8MgrOMJ1jeUF6fnzdcTDltk6jemSFL2
 ZnEdXEBL+VEinpdMkziuZszm9OhiucMqo53Yf6SeTWE39ydNLafBF/ZWK1pce2OpEY9ibmATvHz
 1RO5axQBAsODv55E=
X-Received: by 2002:a5d:4049:0:b0:32d:a57b:8c8e with SMTP id
 w9-20020a5d4049000000b0032da57b8c8emr8205964wrp.53.1698758364619; 
 Tue, 31 Oct 2023 06:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/wb/0kdG1vk3V520VwGZBm6FOcQNOCVji81tihmZ0urjN1g4aUspxMQByd+jCejUr+3CSdQ==
X-Received: by 2002:a5d:4049:0:b0:32d:a57b:8c8e with SMTP id
 w9-20020a5d4049000000b0032da57b8c8emr8205937wrp.53.1698758363610; 
 Tue, 31 Oct 2023 06:19:23 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z14-20020adff74e000000b003200c918c81sm1482783wrp.112.2023.10.31.06.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:19:23 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V2 6/6] tests/qtest: migration: add reboot mode test
In-Reply-To: <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Wed, 25 Oct 2023 12:44:29 -0700")
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 14:19:21 +0100
Message-ID: <87y1fj6iau.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


