Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76F7DE4DD
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 17:53:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyESA-0000pJ-3u; Wed, 01 Nov 2023 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyES8-0000mw-5F
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:52:24 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyES6-00015H-1H
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:52:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03B1021A47;
 Wed,  1 Nov 2023 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698857539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVq+jvlte7YTB4DiiKEnaf8os16HhKBTh4htTE+P1Yg=;
 b=TRDibI2XsZEFe5HXi+F+zM3Y4HsnyzfXScvPgV6RPLfk6fR+B59TSSc+PLbn3Bf+yeuR9X
 BGgG7UfzLAKRRyGzsA+oorE+Ump0L0rL0rOAfwyLKMnrXYmDTRs1/tOiy/7SrtrQ7IMoin
 cfGprc1ftZ6sZY6nmLybRqA+v3BAnm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698857539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVq+jvlte7YTB4DiiKEnaf8os16HhKBTh4htTE+P1Yg=;
 b=s3WNpZqCIMSiKR2/xWA1e9L5IpHfD05TL1aHPoUYBJtI+6R2tqhfKMAbFnLRslj2ovCox8
 G+j0Zs1MPYXmH3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B0E01348D;
 Wed,  1 Nov 2023 16:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I0i3DEKCQmWXSwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 01 Nov 2023 16:52:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
Subject: Re: [PATCH V2 6/6] tests/qtest: migration: add reboot mode test
In-Reply-To: <4c70d707-d33a-4f33-bd1c-a0811776daed@oracle.com>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
 <87ttq5fvh7.fsf@suse.de> <19355543-0534-4f9e-b85a-54b8f46e73b6@oracle.com>
 <4c70d707-d33a-4f33-bd1c-a0811776daed@oracle.com>
Date: Wed, 01 Nov 2023 13:52:16 -0300
Message-ID: <87pm0tfmbj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Steven Sistare <steven.sistare@oracle.com> writes:

> On 11/1/2023 9:57 AM, Steven Sistare wrote:
>> On 11/1/2023 9:34 AM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>>> index e1c1105..de29fc5 100644
>>>> --- a/tests/qtest/migration-test.c
>>>> +++ b/tests/qtest/migration-test.c
>>>> @@ -2001,6 +2001,31 @@ static void test_precopy_file_offset_bad(void)
>>>>      test_file_common(&args, false);
>>>>  }
>>>>  
>>>> +static void *test_mode_reboot_start(QTestState *from, QTestState *to)
>>>> +{
>>>> +    migrate_set_parameter_str(from, "mode", "cpr-reboot");
>>>> +    migrate_set_parameter_str(to, "mode", "cpr-reboot");
>>>> +
>>>> +    migrate_set_capability(from, "x-ignore-shared", true);
>>>> +    migrate_set_capability(to, "x-ignore-shared", true);
>>>> +
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +static void test_mode_reboot(void)
>>>> +{
>>>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>>>> +                                           FILE_TEST_FILENAME);
>>>> +    MigrateCommon args = {
>>>> +        .start.use_shmem = true,
>>>> +        .connect_uri = uri,
>>>> +        .listen_uri = "defer",
>>>> +        .start_hook = test_mode_reboot_start
>>>> +    };
>>>> +
>>>> +    test_file_common(&args, true);
>>>> +}
>>>> +
>>>>  static void test_precopy_tcp_plain(void)
>>>>  {
>>>>      MigrateCommon args = {
>>>> @@ -3056,6 +3081,8 @@ int main(int argc, char **argv)
>>>>      qtest_add_func("/migration/precopy/file/offset/bad",
>>>>                     test_precopy_file_offset_bad);
>>>>  
>>>> +    qtest_add_func("/migration/mode/reboot", test_mode_reboot);
>>>> +
>>>>  #ifdef CONFIG_GNUTLS
>>>>      qtest_add_func("/migration/precopy/unix/tls/psk",
>>>>                     test_precopy_unix_tls_psk);
>>>
>>> We have an issue with this test on CI:
>>>
>>> $ df -h /dev/shm
>>> Filesystem      Size  Used Avail Use% Mounted on
>>> shm              64M     0   64M   0% /dev/shm
>>>
>>> These are shared CI runners, so AFAICT there's no way to increase the
>>> shared memory size.
>>>
>>> Reducing the memory for this single test also wouldn't work because we
>>> can run migration-test for different archs in parallel + there's the
>>> ivshmem_test which uses 4M.
>>>
>>> Maybe just leave it out of CI? Laptops will probably have enough shared
>>> memory to not hit this. If we add a warning comment to the test, might
>>> be enough.
>> 
>> in test_migrate_start, I could set memory_size very small if use_shmem, and adjust 
>> start_address and end_address. Can you suggest a safe size?

We need at least ~4M for the MAGIC_MARKER logic to work. Then each
architecture will have a minimum memory size it needs to even be able to
boot. Then we'll need ~2M (to be safe) for the a-b code itself.

One issue I can see already is that ppc needs at least 256M to boot. We
currently only test ppc with KVM, but we need to make sure the custom
runners (not even sure we have ppc baremetal) would have enough shared
memory. Another issue is that there's not much stopping us from testing
ppc with TCG as well. In fact, I'm highly in favor of bringing back
s390x and ppc64le with TCG for migration-test. It's just a pain to test
those otherwise.

x86 seems like it could go as low as ~6M.

aarch64 only needs 512k for the kernel, but I'm not having success with
less than 110M. Probably some firmware + device tree taking up space,
I'm not sure.

>
> Ugh, I would also need to dynamically change TEST_MEM_END and ARM_TEST_MEM_END in
> a-b-bootblock.S and a-b-kernel.S, like I do for the suspend_me variable in my
> work-in-progress patch "tests/qtest: option to suspend during migration".

I'm leaning towards just checking the GITLAB_CI environment variable and
skipping the test on CI.

Juan, any preference?

