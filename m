Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE07DCBF7
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:39:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxn4Z-0000mx-Gw; Tue, 31 Oct 2023 07:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxn4R-0000jn-QO
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxn4P-0004c1-Kt
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698752284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qAcd7tvHncS8tzRA1hH+6YVb8+p62dS9hEMAMLuDte0=;
 b=W6jcH0wIB25dYx/bbUHKKD6rfNRHMKJBBteSXaPCAfD/yRzptzOlp4wPVHBuWJi5fuScjk
 /Ioa1+Z58AclCf8LAfhkSBRYZTebkwzQnYdoTyafwlmjQYiEDFUIVVUxfmstdfcdVeSVKn
 eMndrdnEQNjiG3XdstWR3qhJ5D4+exs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Ud6mAyH4Msyj7UnTcmdBYw-1; Tue, 31 Oct 2023 07:38:03 -0400
X-MC-Unique: Ud6mAyH4Msyj7UnTcmdBYw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408597a1ae3so40378225e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698752282; x=1699357082;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAcd7tvHncS8tzRA1hH+6YVb8+p62dS9hEMAMLuDte0=;
 b=p1+hhz6d7jxIqAb6FK3FhoRRcUTRcis8tumm0pV3Th0X9Lo+TuI7MQjScohsg7vHzI
 GH5aQ0kwXplD8GlpEN5Nk4S9AQ0OYwq3q+yYjaG9yoJBYCYhh3B8rkvU3IvZcvHXoSXa
 0Z4Jbmjgj+PDTd16sAzZh1gUqZFJGcVXJRFnKpzujJVYBfEo01YrSPOBc4YQ5WD79Vk9
 im1/R2z+RTbK8g9CJ6VD/Y0wVZx1IPG0NLnYJC9LWp+NfmNGk+55khU3Pc7yJVjtockv
 TEEnqPGTIHcv5/Y1mR00cNOCvk2twpRneYO8QdS/usiPhQAoBpka3Y1HIKzuSfemCTpI
 owRQ==
X-Gm-Message-State: AOJu0YwST8lw2gZgMnFFgOBh4azZCs+aUy3GseHRlBwLMVfwJEra4qpL
 lxe8ln325EM4Q01Ldf00N7bsPX1gR/MUqlS6PWDUH+V4RmE2kDH2YkNsdRGJLu6AuR87KBV/JB/
 dQNYRcvlI6Aj2tXA=
X-Received: by 2002:a05:6000:4b:b0:32d:570b:c0a4 with SMTP id
 k11-20020a056000004b00b0032d570bc0a4mr8951939wrx.27.1698752282296; 
 Tue, 31 Oct 2023 04:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3U+oGDtZEch54OQwZY2QStrgT2D/xwfIuDv2SEweIwpoERNAJnSmqZmSjVqvk2gmisTxMbw==
X-Received: by 2002:a05:6000:4b:b0:32d:570b:c0a4 with SMTP id
 k11-20020a056000004b00b0032d570bc0a4mr8951925wrx.27.1698752281942; 
 Tue, 31 Oct 2023 04:38:01 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p11-20020a5d458b000000b0032d9337e7d1sm1348816wrq.11.2023.10.31.04.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 04:38:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 1/5] migration: Set downtime_start even for postcopy
In-Reply-To: <20231030163346.765724-2-peterx@redhat.com> (Peter Xu's message
 of "Mon, 30 Oct 2023 12:33:42 -0400")
References: <20231030163346.765724-1-peterx@redhat.com>
 <20231030163346.765724-2-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 12:38:00 +0100
Message-ID: <87v8an81k7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> wrote:
> Postcopy calculates its downtime separately.  It always sets
> MigrationState.downtime properly, but not MigrationState.downtime_start.
>
> Make postcopy do the same as other modes on properly recording the
> timestamp when the VM is going to be stopped.  Drop the temporary variable
> in postcopy_start() along the way.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


