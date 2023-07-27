Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF4764368
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 03:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOpJO-00088p-2E; Wed, 26 Jul 2023 20:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOpJM-00088b-JK; Wed, 26 Jul 2023 20:57:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOpJL-0002uF-1P; Wed, 26 Jul 2023 20:57:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-54290603887so228089a12.1; 
 Wed, 26 Jul 2023 17:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690419417; x=1691024217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKKdgI+Xo1EjxoSJH/wd3Zw07MDaM5sy1VMrpD1lvGk=;
 b=naUB/f58D6i2ZRzLVmKQ0+XB/MvzpJYWgZgrGkAN05UDWmA8H62ip+NTaMJF/HqRte
 sg9JZVUZVVhVK7W8np7xLXCQqCa7vLYfBkCEescS+cwC0aFS9CR65ev3ZCdgsVBeIUq1
 7v/wvSKSdqQSlJDg9ART74aw/NpgWzBun7BC+7MpwxvbhnjiDsTzOeuiAHV1yPYnklfK
 Xfs5eL6Z0YdlBe4kTNX2nqGdJoLWs/PXOiFVKQjVw3Fe7e98/8nmbRfLnWhlidZHBhjK
 Et0elOqVTp+TcPfTf5ZADi+Obemzj0EHvOaqVxULJESrKLpAL73O5i0sVPB5c/IpyRHP
 Mz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690419417; x=1691024217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eKKdgI+Xo1EjxoSJH/wd3Zw07MDaM5sy1VMrpD1lvGk=;
 b=hjvrmhK/FyxtPz5RLqxOe51gT3qw/WELeY5MDqbxu5+MMJa/D0Y46ApbqonjI2VfwY
 wbe+XNbVd66AjaeDel5GDH7RomyaUQlNyppvbbOuOgkncK5SuMqeXgkLslMYHsmlB8Fc
 SC/ZHSG5tpYI1a065R33pHtGQbuZHgmdKE5X6HoWXVY6OhXaS3Bw4pE/BdiO/L1+dbV0
 2nZfAOmV8diTpOhdRC4rSJCcnnwYMal3kMKltvdmsbgbdTDEARRm1ALOdRq4n+3VkQZ5
 x9kgAcwPlGrvbpffVNflaocR8RTkOYRkBqILelf7in4tretlHs2a67KVNb/DtwL4URoJ
 pWAQ==
X-Gm-Message-State: ABy/qLYs9JHk7Kb9o1QBnOFhS8JAa3Pd9shFZtiGWkw7RojVmWu8H2qL
 /UDYzei4oqSXz6+knQlbQ5U=
X-Google-Smtp-Source: APBJJlGpypiJFTLQp/gOiho2Mv6OIvh8wzl8zukC9LxJ5GT1SM6ba6a8Yb27S9FvTbbxPxlfilgusg==
X-Received: by 2002:a05:6a20:3256:b0:13b:a5df:ebb1 with SMTP id
 hm22-20020a056a20325600b0013ba5dfebb1mr3064974pzc.34.1690419416568; 
 Wed, 26 Jul 2023 17:56:56 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a170902eb4500b001ae0a4b1d3fsm168012pli.153.2023.07.26.17.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 17:56:56 -0700 (PDT)
Message-ID: <577a2d20-b0d5-fffd-7377-587b4dfed3ca@gmail.com>
Date: Thu, 27 Jul 2023 09:56:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, lvivier@redhat.com, jeuk20.kim@samsung.com
References: <cover.1690348453.git.jeuk20.kim@samsung.com>
 <20230726193626.GD822884@fedora>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20230726193626.GD822884@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/27/2023 4:36 AM, Stefan Hajnoczi wrote:
> On Wed, Jul 26, 2023 at 02:30:49PM +0900, Jeuk Kim wrote:
>> Since v6:
>> - Add tests/qtest/ufs-test.c to test ufs initialisation and I/O
>> - Add struct UtpTaskReqDesc to include/block/ufs.h
>> - Fix ufs_log2() logic
>> - Fix ufs-lu to use 4K as default block size to match the ufs spec
>>
>> Since I created a new file, tests/qtest/ufs-test.c, I added Laurent Vivier to the cc list.
>> Thank you.
> 
> Modulo the comments about the test case:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thank you very much for your detailed reviews so far.
I will resend the patch reflecting your comments on the test case.

Thanks again!
Jeuk

