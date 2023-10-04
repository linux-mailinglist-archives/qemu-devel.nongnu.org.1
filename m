Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6837C7B8226
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2jz-00065z-SJ; Wed, 04 Oct 2023 10:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2jv-00064n-Mx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2ju-00079c-31
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696429237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V48ZP1MstJU0g8aENgQUi185lJMNu6BIKVmdhZ4t4vM=;
 b=H9SCW72+hurn9dQMcSCqMPVyfqIxHzheOgpKiUhZ6tVWQ8EipTzCpphIvCl+nG0JouP3KL
 1i+twLTgq6F+XaeLBgpg+jcjiCV3zkY2xPXbbwpfdAF7fmc0KnpApxOME9ZfX5A6Gl3c0y
 JDTfY6f7oF1V/DMV1YdrVTBNIKdxGA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-UL14W1MNMzaIxadkCk-9Lg-1; Wed, 04 Oct 2023 10:20:33 -0400
X-MC-Unique: UL14W1MNMzaIxadkCk-9Lg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so1679034f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696429232; x=1697034032;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V48ZP1MstJU0g8aENgQUi185lJMNu6BIKVmdhZ4t4vM=;
 b=VBxcNxZANxliqHF0uzeqhCwkHgHsRXsAIdzPxO/ldCfsz4RYVvtnkIQcMOEF12mD19
 dVyz6Yu6U66jxL/wLKDJsB/HC0Gu9jzBeWH9Mc/UJDWgzkJSQRzlS96qqMoicL+HT3km
 180+yl+jTi+MGvYd6ITi3rpVxZ70dLAuQukWsWcTaG8asCY40xuOtR40QdV00hQMPKUc
 +vNY+jHDBd3iJs4p0muYLDSJNwl1j6Wg6zOB1EdUs87QwS49l2BkURX1HLgxsK80SufS
 iUwP122aQuJ4XezQfHSXCjb1ju/BVvyxn5HTvgMCjxQhWDWZvBi17LZY88Mjv37Nwi2j
 fe8w==
X-Gm-Message-State: AOJu0YxHaUrk+db5kfBO9SK2a03OEb8PwJIleIXzMcOGH5/vTN9BExUS
 tntBSzpjIBe+5v//idC6OBjKXMVBYBDToVixdAV/Dr0Cmtu6K5ivEceZdRNMW7mV8NEkjcMNhG4
 bVJuOinwrXRu6nOo=
X-Received: by 2002:a5d:628a:0:b0:320:254:b874 with SMTP id
 k10-20020a5d628a000000b003200254b874mr2248446wru.11.1696429232431; 
 Wed, 04 Oct 2023 07:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2e0b3AvB2q8ZK9qzqK5rssyXTxT99fT/RKV/Zq4DU8Fh/2+zsCYNuZt7PyWzkAhBnj5aqcw==
X-Received: by 2002:a5d:628a:0:b0:320:254:b874 with SMTP id
 k10-20020a5d628a000000b003200254b874mr2248422wru.11.1696429232075; 
 Wed, 04 Oct 2023 07:20:32 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c6-20020a5d4cc6000000b00325c7295450sm4144527wrt.3.2023.10.04.07.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:20:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>,  qemu-s390x@nongnu.org,  Steve Sistare
 <steven.sistare@oracle.com>,  Michael Galaxy <mgalaxy@akamai.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 09/11] migration: file URI
In-Reply-To: <87o7hepjpl.fsf@suse.de> (Fabiano Rosas's message of "Wed, 04 Oct
 2023 11:04:38 -0300")
References: <20231004124038.16002-1-quintela@redhat.com>
 <20231004124038.16002-10-quintela@redhat.com> <87y1gi4i32.fsf@suse.de>
 <87cyxu33fp.fsf@secure.mitica> <87o7hepjpl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:20:30 +0200
Message-ID: <87fs2q1nbl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> wrote:
>>> Juan Quintela <quintela@redhat.com> writes:
>>>
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>
>>>> Extend the migration URI to support file:<filename>.  This can be used=
 for
>>>> any migration scenario that does not require a reverse path.  It can be
>>>> used as an alternative to 'exec:cat > file' in minimized containers th=
at
>>>> do not contain /bin/sh, and it is easier to use than the fd:<fdname> U=
RI.
>>>> It can be used in HMP commands, and as a qemu command-line parameter.
>>>>
>>>> For best performance, guest ram should be shared and x-ignore-shared
>>>> should be true, so guest pages are not written to the file, in which c=
ase
>>>> the guest may remain running.  If ram is not so configured, then the u=
ser
>>>> is advised to stop the guest first.  Otherwise, a busy guest may re-di=
rty
>>>> the same page, causing it to be appended to the file multiple times,
>>>> and the file may grow unboundedly.  That issue is being addressed in t=
he
>>>> "fixed-ram" patch series.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
>>>> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> Message-ID: <1694182931-61390-2-git-send-email-steven.sistare@oracle.c=
om>
>>>
>>> Juan, FYI we have tests for this feature already reviewed and ready to
>>> merge:
>>>
>>> [PATCH v5 0/6] migration: Test the new "file:" migration
>>> https://lore.kernel.org/r/20230712190742.22294-1-farosas@suse.de
>>
>> I searched for URI and didn't found it.
>>
>> Will got it on next PULL request.
>
> Do you want me to do resend? It's no big deal.

Not integrated already on my tree.

Thanks.


