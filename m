Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FA73F87A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4lz-00055n-2m; Tue, 27 Jun 2023 05:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4lq-00055E-N7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4lp-0003X4-BR
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687857236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aWIaBg9yhzO1SA3Ovgwe7oDsIx2mNNM7Q6O47BTrLw8=;
 b=B2Pjx/MP5FBaXgjlDo7PqL925Co2yhLOvIqkdpkY6KHSPTf5016+VyRGiRAWPF5tt13x32
 JTRp85otyA7whH6x4WCa9OYaAKQrx/B7+tVS+vW7tGHMFuq0acpbFe3+2bVhvFG1ri1f0Y
 zpaqB5695wJk8ZNqzDucMqSB58Cj1EM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Ft8hvmgcPO-fl3zWpPjlyw-1; Tue, 27 Jun 2023 05:13:55 -0400
X-MC-Unique: Ft8hvmgcPO-fl3zWpPjlyw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb76659d6cso1781403e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857233; x=1690449233;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWIaBg9yhzO1SA3Ovgwe7oDsIx2mNNM7Q6O47BTrLw8=;
 b=Ze3fzyZS59iVYPcEx1oiNjray+VFWA/6/3nyFvq+2ejX7UjM/FrB8nA//5YzbLf1Nt
 2HyxXSaC8H3zFDUWwCfms/YOD5k2j/sZaAhG0RoU1R7gcCIyXV/MuZ3/ZpM5rCZot3+7
 A2uXRkYlMyJ7+5LMHBFmda4MiBoI2D/VpS1kAvcBQZdvJ3i+x2AGq4ZKYtM9ywvgsf8d
 3Scg51AYXUUayAeRc/TFxK/cENklNX2XTKifSFqDlEBy1Cf3BeN3mnycbkEf7KYkaJTw
 GYl0H0RBKoPoKlbYT2rTc6Cs5H5FUuxH449uniuVTRG1TEOn75TVGSfCsCxxkfOMlSnD
 XOow==
X-Gm-Message-State: AC+VfDxUDXBvk9L7lGzLrMsBOoMOZ9gsmgyzzLKBoUHGaulGzy73Icpv
 yaP/ErB/lH4SMO+tOCZsgYRbM526g56oKHrZd1X6ASSJUtePJ6Kin1+BRMMRls6q7MZewQEzU6u
 bUBU5YNbYB8XKVNc=
X-Received: by 2002:a19:771d:0:b0:4f9:5404:af5 with SMTP id
 s29-20020a19771d000000b004f954040af5mr11224233lfc.46.1687857233750; 
 Tue, 27 Jun 2023 02:13:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tDulmZMsWdnfYPJmWJvMGhfwVzvcRgVN367tVn67JqvjK5uKZgXqW9WeZNPCfvaZcIMZq2A==
X-Received: by 2002:a19:771d:0:b0:4f9:5404:af5 with SMTP id
 s29-20020a19771d000000b004f954040af5mr11224227lfc.46.1687857233380; 
 Tue, 27 Jun 2023 02:13:53 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q14-20020a7bce8e000000b003fba92fad35sm330596wmj.26.2023.06.27.02.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:13:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 4/6] tests/qtest: migration: Use migrate_incoming_qmp
 where appropriate
In-Reply-To: <20230626182210.8792-5-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 26 Jun 2023 15:22:08 -0300")
References: <20230626182210.8792-1-farosas@suse.de>
 <20230626182210.8792-5-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 11:13:52 +0200
Message-ID: <87y1k5b73j.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> wrote:
> Use the new migrate_incoming_qmp helper in the places that currently
> open-code calling migrate-incoming.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


