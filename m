Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C667CF7E3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRic-0001nm-Hh; Thu, 19 Oct 2023 08:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRhv-0001dz-5T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRhr-0001mn-KD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697716850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hT1mDwxy/0zKKL+06g5JQNwv/Mc83N5oJSzQxary8sI=;
 b=QqQ/2LLT8MhWyRRz2Dg+8tGlJyIyqfyW+mxlhDcV0VETPcQqSbCNJCfhBoR/seGG9HRrb5
 dSBw+dyY/rtcYC/kHpSis+AEVeHFzpFWR4C3spL2qbDi6W/cbLWbmHIQRnX+LzxWOSvCxP
 MyLfN7+fZjI6kyHivjj06/slS2TNYgs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-2w4jY_zfONCYyADVrhkXqg-1; Thu, 19 Oct 2023 08:00:39 -0400
X-MC-Unique: 2w4jY_zfONCYyADVrhkXqg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32ddd6f359eso231496f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697716838; x=1698321638;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT1mDwxy/0zKKL+06g5JQNwv/Mc83N5oJSzQxary8sI=;
 b=E4YwycV+uPMnOLqSO5DUQs5mAkEQRjnEVHY92pW5sgxf0Qo5cR+PnUwgM3Ox+FVypM
 D5eZIFoe6ep9kQHFq8SQuT5ylygrjYMMDoNfsmXzD08ibGCPW9RTh0mjABR+1R2ZdhCH
 xm5U9OEpqmgSACC7onhHsMtc84y3UdrPKP6/RhO22EzMEmOY4YE0XBidJCEu0f9TncgE
 ZK6fWOBljtqfOpMVrDiYg/5Gcp9I7H8Z57YVSMNEgoYXnAeI5e4Sx+7/sOq6PNMAwBQj
 xjoxpoohP0Vb2TDY3m6n7mMQ0UXcttjP5hTAsuiI9PNFnj9WgE22/d6aLHzVmWPbHnoF
 AxdQ==
X-Gm-Message-State: AOJu0YwTrEm56nV0EZe4lql+3AAkfv1MuQO7sP98wKxmX8MnvyjbpErW
 txgvOhE1bESgcwuXbjMCs2bmajka3UDYcqz6MhXiSD1J/BxydvQdTqnm+bQuYLxn9hozwdoALMF
 lalHse7+B8klM4wk=
X-Received: by 2002:adf:ec46:0:b0:32d:a7d0:247a with SMTP id
 w6-20020adfec46000000b0032da7d0247amr1326102wrn.48.1697716838301; 
 Thu, 19 Oct 2023 05:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBffw/ZXfWgdFWO4tn/TXtvVWN/PFj3WNYA1zS8J87UJAjCeWHdfzGucjXBJykwpadyd24eg==
X-Received: by 2002:adf:ec46:0:b0:32d:a7d0:247a with SMTP id
 w6-20020adfec46000000b0032da7d0247amr1326075wrn.48.1697716837874; 
 Thu, 19 Oct 2023 05:00:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q18-20020a05600000d200b003233b554e6esm4302338wrx.85.2023.10.19.05.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:00:37 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 09/12] tests/qtest/migration: Set q35 as the default
 machine for x86_86
In-Reply-To: <20231018192741.25885-10-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 18 Oct 2023 16:27:38 -0300")
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-10-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 14:00:36 +0200
Message-ID: <87r0lq4yaj.fsf@secure.mitica>
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
> Change the x86_64 to use the q35 machines in tests from now on. Keep
> testing the pc macine on 32bit.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


