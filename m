Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0B87D4DD3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEi3-0005ay-Ji; Tue, 24 Oct 2023 06:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEhw-0005TN-J4
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEhr-0005AR-I7
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698143533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JWwHvVukhjNZFheZAQP/bPqAXtLHVc4d9CzBD9AxkSM=;
 b=VmKoOzeE9I0nK//sy82u86naBkQ4csWYhyEj9Xlou2Dd9/jjlM2YrWuGPLdeyE1wzsqk8d
 +uOp7oZujqxDHuSG+xvDZv9hcb0Dk4inQHoRHTYPYfhMGUrOcvKnt+T+m3uGhtsSWEl4O8
 C8cIT53PxSw8UCWf0JD+Ao7BbbjDswk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-wO49UqO4NZOQ1wETUjm_Fg-1; Tue, 24 Oct 2023 06:32:12 -0400
X-MC-Unique: wO49UqO4NZOQ1wETUjm_Fg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da8de4833so2105221f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698143531; x=1698748331;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWwHvVukhjNZFheZAQP/bPqAXtLHVc4d9CzBD9AxkSM=;
 b=Z3ZJMELPW0c1wN4sUtOy+AgPJkrYl4FER3KDwmdoZ0zbI5iuMiwtN/5e3NB6yxGdu/
 hPFSGotzLwaap6wudxbiaPkoVCu+RDk/sL8jU6e0SnPsAWIiClfwVaJIt4lUZMW0ql5E
 uN7241XUgft6wLlX1+80xtKdATgBcIrdaYDAUvuaKuoIhCmbYN4Kk1dZ6CloqIRmCTkc
 vfok6dXUzaeKSEHPtDUutnRQiMAUswt4w0zdWfwKDQgJVsNuG1d2d+VJQ8ts4ueLVK4a
 t/ukWIRJQ6pf183o9rDH1cYLcUb4Pp9CWjfcxRG1dyxqQ+1+dwl2WpphD8VGLjZHwXoT
 by4w==
X-Gm-Message-State: AOJu0YyTyPpTwV9TQib+PeruTGXWCpCrer+vuXA06NSgKm9tSELnuz5m
 0QReXs0IwJo4MCKd9wu2uVwwZWp2QDFlAPsAI2ljrItFSqsDp4p3rVHT1KWGhhBKnQXzp3/PE16
 Ncy607yFzZIU0O0o=
X-Received: by 2002:a05:6000:b11:b0:32d:b6a2:8de2 with SMTP id
 dj17-20020a0560000b1100b0032db6a28de2mr9003355wrb.39.1698143531234; 
 Tue, 24 Oct 2023 03:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWRgl1CB4bAthzqxkYARlGl2T5imPKehU5IXdJ/BpxetR57xGaCck8jYz6MN4iDf+AsKo0OQ==
X-Received: by 2002:a05:6000:b11:b0:32d:b6a2:8de2 with SMTP id
 dj17-20020a0560000b1100b0032db6a28de2mr9003340wrb.39.1698143530921; 
 Tue, 24 Oct 2023 03:32:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d14-20020adffd8e000000b0031984b370f2sm9583192wrr.47.2023.10.24.03.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:32:10 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Markus Armbruster <armbru@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
In-Reply-To: <20231024092220.55305-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 24 Oct 2023 11:22:20 +0200")
References: <20231024092220.55305-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:32:09 +0200
Message-ID: <87edhk1fbq.fsf@secure.mitica>
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

Thomas Huth <thuth@redhat.com> wrote:
> Rename the variable here to avoid that it shadows a variable from
> the beginning of the function scope. With this change the code now
> successfully compiles with -Wshadow=local.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.

> ---
>  v2: Need the value for the qemu_file_set_error() line, too

I also hate qemu_file_set_error().

Direct translation of Spanish Saying:

Evil of many, consolation of fools

O:-)


