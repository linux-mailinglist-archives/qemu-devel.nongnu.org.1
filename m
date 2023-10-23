Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 033787D3387
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qut90-000784-2P; Mon, 23 Oct 2023 07:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qut8T-000776-Aw
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qut8R-0003N2-RO
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mRQ8E1xvKA+L7l9skhMn7f+BJe6mtIg8kFIrHheAdW0=;
 b=hLuNSEn6me90wX1+WzlUHh1Y6mn2QepiQwDOwHPmGaWYiIGS8wl4gkqB6IqKDhGOsZP7Md
 Jt/BadZWwQ+K+ygIU1FpbUuVhZ80rz+xUaCl6mvfjzQK2TYiYRqe8uk4YDq6ppAB92ybqm
 rlNdA0R8XV0FBaJxm3G7Vs+1W2V7ugk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-X_jiXzeuMMqahOtWWEST2A-1; Mon, 23 Oct 2023 07:30:12 -0400
X-MC-Unique: X_jiXzeuMMqahOtWWEST2A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507b0270b7fso3250788e87.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698060611; x=1698665411;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRQ8E1xvKA+L7l9skhMn7f+BJe6mtIg8kFIrHheAdW0=;
 b=S8uKi0+b/9j+MTuX57a7w7AVbWk0jpUzJVoTgwiu3W78eZn2qpJDkCiU/6349tXYJY
 Gwf1WE9FCkEfJau4WzIAKGxUgppgxUsy7XkCu1FHvp2wbgvOgJ4/6r8+p7QYp1sQb/m5
 Hcg0aVuG/WK7fu3ybkzPGiBofYa/+xenH3yn8aSvcqUmFESruB+Kkl6KBFuvrMIH8s1G
 WWnAb2ZIC/mZ2dmcEAh8lneHAlF53xuNS2zlV6MinR2An0qJqBecUdiB0Bj2VU4SJrKr
 4nW33OoglbE7RuxcFRi7CidtO21D7qLUqmjdQ9A5Ro+Ild352nqi/OhSx88d/QzJlASL
 Vz2g==
X-Gm-Message-State: AOJu0Yx174rm8JlIX2W/2h5XgZTZ1r2PuOU00SFL+tpXMUz82p85jkrI
 Dtev80BHcY94uKYYJ8vzoM/WyhMKSW0OnFpaiwsygQBkzNwkwUp1WCRlbnYz+CCkHhbsNpox1tW
 tlEMzNwNYss6b9F6+d8LumBA=
X-Received: by 2002:a05:6512:24e:b0:503:2e6:685e with SMTP id
 b14-20020a056512024e00b0050302e6685emr5675360lfo.14.1698060611117; 
 Mon, 23 Oct 2023 04:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcmEwIKGhZAy03YDU/71FZYjvTxJIkQPFXnvPX11IP9HjvGB9hqmgBFV4QArvG4Gt97Pstxw==
X-Received: by 2002:a05:6512:24e:b0:503:2e6:685e with SMTP id
 b14-20020a056512024e00b0050302e6685emr5675345lfo.14.1698060610704; 
 Mon, 23 Oct 2023 04:30:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j7-20020a5d6187000000b003253523d767sm7606744wru.109.2023.10.23.04.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:30:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] hw/ipmi: Don't call vmstate_register() from
 instance_init() functions
In-Reply-To: <20231020145554.662751-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 20 Oct 2023 16:55:54 +0200")
References: <20231020145554.662751-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 13:30:09 +0200
Message-ID: <87pm15shj2.fsf@secure.mitica>
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
> instance_init() can be called multiple times, e.g. during introspection
> of the device. We should not install the vmstate handlers here. Do it
> in the realize() function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

It fixes my issues.

Should I take this through the Migration tree?


